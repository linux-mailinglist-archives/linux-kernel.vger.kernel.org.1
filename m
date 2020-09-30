Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65027E049
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 07:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgI3F06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 01:26:58 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33274 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3F05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:26:57 -0400
Received: by mail-ej1-f66.google.com with SMTP id j11so981613ejk.0;
        Tue, 29 Sep 2020 22:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Je2DNnA/FKfKTqizjipmzNv3owWScP9mvLVXfLsSsn0=;
        b=bky6nP4+mvw23ij9R9+Uci4t0rQbBe2UnZQXSdsfBq5PII+j0mhor9f24WjAo+sOuu
         ZP0RZXwKXaKut5zTuD+ivg8vHMhrLJKE0uWJMSXGSkGb9FHhySVMB78TAGxSapdyVN3u
         a+WUKnRZtRSUjxDxez7WZkBIhe7LdxMC0uLwcQwnby3CR9VDMZoxGDJHVjY2AZyxoFNY
         7JFfdH7IpOHdzbGx3typ1k/pKhlSbspx7vnGoVxuxTootOPgwNsvK4sUXcNByEWc4ejW
         hDS+Jlr1W8Kzq8xbLgeXCVWRMoYPy6HfD3mofYWrNCoaIz6eF063ddXnfXOBuRvAnoe0
         X91g==
X-Gm-Message-State: AOAM533Nz3OdHcFKp7A1tOthdyVuK3e/0iNPZgJ68NUhZO2QEWYlvAq6
        m9wVwMIhLZCCnZbzzM59MjehvIVFAO10SA==
X-Google-Smtp-Source: ABdhPJxZWLUkyQs9Cnkhkk/mXboQK+ISYt9QsCL2oAivHTd7YbInKhTXYmmYx659HgrqEpkNaVZF/A==
X-Received: by 2002:a17:906:8559:: with SMTP id h25mr1076818ejy.536.1601443614199;
        Tue, 29 Sep 2020 22:26:54 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z16sm392636edr.56.2020.09.29.22.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 22:26:53 -0700 (PDT)
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
To:     Peilin Ye <yepeilin.cs@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN> <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <7d341242-9612-d0ee-4b79-e93882fad73f@kernel.org>
Date:   Wed, 30 Sep 2020 07:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929123420.GA1143575@PWN>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 09. 20, 14:34, Peilin Ye wrote:
> the work in general? I couldn't think of how do we clean up subsystems
> one by one, while keeping a `console_font` in `struct vc_data`.

Hi,

feel free to change struct vc_data's content as you need, of course.
Only the UAPI _definitions_ have to be preserved (like struct console_font).

thanks,
-- 
js
suse labs
