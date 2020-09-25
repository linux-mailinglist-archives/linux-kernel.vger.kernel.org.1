Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF12780D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgIYGqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:46:09 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36021 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgIYGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:46:09 -0400
Received: by mail-ej1-f68.google.com with SMTP id e23so2149473eja.3;
        Thu, 24 Sep 2020 23:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYUVlOT19blT7yQ0uNpxiiyC65ymzzyJu/JFbGh28VU=;
        b=Nl/aWedyGMGy068OdRfy40a3sQcXGA/jmBODeM4iNsp4jAkW3ctcM+dwzj5msowfHk
         fHvfKonjTGVGoKk8tfAM+ROPw62jcWv4dzsFtGIdlGbouXxqyBQa5lo0fES/CIBsTEoi
         b0viKxy4IOotvu6nKj1mwSyMokEzjlaI2spLjJVytkm5UDqpVnt7+CnQvb22p6c2ng3S
         aXszRrf++uvXhE//3xnINvccOZxFWixpEOb1VjcgwHbrbWPdnAaTl9F/hOwEEYmIw1EA
         EPtRPy2kZbWhRH/z5O99S/T1AOrXiOMgr0t/S1F6cfrgopcE/k/9czcbWWJFrGquDGZR
         1P5w==
X-Gm-Message-State: AOAM5316+Fk+LDOKPLh9S8gX8WwUoXOT3QqUKlaAI36usVpDQwkhCTDm
        LNj4sCBcA3C8zaMMgiyQsrdlPLphOMVtFQ==
X-Google-Smtp-Source: ABdhPJxgebLlwHKK36J+ozJlcSYTuZirtezaJm/YbNIHt6jb6McE2nmJtmt/9E/eEdXLK6mduUzIlg==
X-Received: by 2002:a17:906:119b:: with SMTP id n27mr1273157eja.124.1601016366763;
        Thu, 24 Sep 2020 23:46:06 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s7sm1210953ejd.103.2020.09.24.23.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:46:06 -0700 (PDT)
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
Date:   Fri, 25 Sep 2020 08:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1600953813.git.yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 09. 20, 15:38, Peilin Ye wrote:
> Hi all,
> 
> syzbot has reported [1] a global out-of-bounds read issue in
> fbcon_get_font(). A malicious user may resize `vc_font.height` to a large
> value in vt_ioctl(), causing fbcon_get_font() to overflow our built-in
> font data buffers, declared in lib/fonts/font_*.c:
> 
> (e.g. lib/fonts/font_8x8.c)
> #define FONTDATAMAX 2048
> 
> static const unsigned char fontdata_8x8[FONTDATAMAX] = {
> 
>         /* 0 0x00 '^@' */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         0x00, /* 00000000 */
>         [...]
> 
> In order to perform a reliable range check, fbcon_get_font() needs to know
> `FONTDATAMAX` for each built-in font under lib/fonts/. Unfortunately, we
> do not keep that information in our font descriptor,
> `struct console_font`:
> 
> (include/uapi/linux/kd.h)
> struct console_font {
> 	unsigned int width, height;	/* font size */
> 	unsigned int charcount;
> 	unsigned char *data;	/* font data with height fixed to 32 */
> };
> 
> To make things worse, `struct console_font` is part of the UAPI, so we
> cannot add a new field to keep track of `FONTDATAMAX`.

Hi,

but you still can define struct kernel_console_font containing struct
console_font and the 4 more members you need in the kernel. See below.

> Fortunately, the framebuffer layer itself gives us a hint of how to
> resolve this issue without changing UAPI. When allocating a buffer for a
> user-provided font, fbcon_set_font() reserves four "extra words" at the
> beginning of the buffer:
> 
> (drivers/video/fbdev/core/fbcon.c)
> 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);

I might be missing something (like coffee in the morning), but why don't
you just:
1) declare struct font_data as
{
  unsigned sum, char_count, size, refcnt;
  const unsigned char data[];
}

Or maybe "struct console_font font" instead of "const unsigned char
data[]", if need be.

2) allocate by:
  kmalloc(struct_size(struct font_data, data, size));

3) use container_of wherever needed

That is you name the data on negative indexes using struct as you
already have to define one.

Then you don't need the ugly macros with negative indexes. And you can
pass this structure down e.g. to fbcon_do_set_font, avoiding potential
mistakes in accessing data[-1] and similar.

thanks,
-- 
js
