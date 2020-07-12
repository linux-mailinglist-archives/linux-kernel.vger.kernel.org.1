Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D4021C8A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgGLK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbgGLK6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:58:25 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4BFC08C5DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 03:58:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so7468044otc.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 03:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kYeWWIRHgqP9iYCDM/kn7rd9Gzo0YcxGmIkxYbaM0zU=;
        b=jnOKsc4temx8BY1bZXriGMzkXDGWDzM+A3p2gSPw/T38j4sg4uUl68rloZRzH9wQTn
         5pBKAmm6BtEfzotrdH5RR8X+2Rx2Jf1M6eTn2f7TJ1ZGrvuztUV4yKMMfObn06PHLm77
         hzfOjIe7IRrMpfCOQBZUowdKjGGhgEu4MclJ60umiLnHxBmVQfmPonujqa/YcYppybJj
         99gRA8PbYXeMYi42OVsfftCy/JV3XElm6c1NbDRrhGIZ/FX2QO/LF7t0r8TUgFjCczSL
         buWIaafQJPXBuVrSbVxshXRbiHPxME0xgSo+687lnvjN6gh6BsbL4kUyN/3nYKsu6sGF
         D2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kYeWWIRHgqP9iYCDM/kn7rd9Gzo0YcxGmIkxYbaM0zU=;
        b=SkjsOiUkX7VS2N9QpuCnr48SV36UGbSNC0ZIYubLjLJlXOH/sPY8IdtBVmRYIW+5oQ
         6YJb/YcRs/XG9EiOqzrHTPKielWVXLyQ36+RhFCie8y193/jSikkPm0jMlC28YxkBmGc
         EfPNLGfGkb8upywlns9m6KmNdULfDIrkjaOc+01hgh0mBkpsxX3OhVENZN49pJMdrWfh
         hDKXS0AOUvQp6TBE+Lh9SDDmxC9G+MAJ1XoaHR0PFDQP/kGnxDpsuIynuhXa/ECaiToK
         G0n6C55da7/pg0Io8QLATRf2RU6F8xyKBqd91ENzqJQbbGthKOfjU/7iHVsFcjcwKdhK
         R/Kw==
X-Gm-Message-State: AOAM533TOXjtSEjM2Ao43EFZJ1BHhL3atq+OmzZXYOqsKBFZWqpQWSrR
        gGa9S3gv/za8C2A21ppYeiJRs8R/SFGJOQ==
X-Google-Smtp-Source: ABdhPJzwfwdOwgM2gLBJlFbqVQR0Yco9rrVsUREuxxg8+EUgCLIrjo6neN/d90N0C2rDU0iewKLcng==
X-Received: by 2002:a05:6830:1517:: with SMTP id k23mr4912550otp.217.1594551503692;
        Sun, 12 Jul 2020 03:58:23 -0700 (PDT)
Received: from ?IPv6:2607:fb90:95b7:945a:fceb:31ff:fed3:9377? ([2607:fb90:95b7:945a:fceb:31ff:fed3:9377])
        by smtp.gmail.com with ESMTPSA id d11sm2488321oom.6.2020.07.12.03.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 03:58:23 -0700 (PDT)
Subject: Re: [PATCH] SUPERH: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        ysato@users.sourceforge.jp, dalias@libc.org, broonie@kernel.org,
        sboyd@kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200709021737.22667-1-grandmaster@al2klimov.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
Date:   Sun, 12 Jul 2020 06:06:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709021737.22667-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 9:17 PM, Alexander A. Klimov wrote:
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9fc2b010e938..bc91bdb0b665 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -74,7 +74,7 @@ config SUPERH
>  	  The SuperH is a RISC processor targeted for use in embedded systems
>  	  and consumer electronics; it was also used in the Sega Dreamcast
>  	  gaming console.  The SuperH port has a home page at
> -	  <http://www.linux-sh.org/>.
> +	  <https://www.linux-sh.org/>.

That's a historical page last edited in 2006 (according to
http://www.linux-sh.org/shwiki/RecentChanges/ anyway) with a self-signed
certificate that pops up a full page warning on chrome about the certificate
being invalid, in a wiki that can theoretically be edited by arbitrary third
parties anyway.

Not a huge man-in-the-middle target.

Rob
