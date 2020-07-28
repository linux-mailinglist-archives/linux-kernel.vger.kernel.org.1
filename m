Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9767230327
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG1Gk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 02:40:29 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45629 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgG1Gk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:40:29 -0400
Received: by mail-ej1-f67.google.com with SMTP id g7so11223151ejw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9LDJcbP5EY7Qv6Dknlse8srXZlwMpETG/crjtwF3dQ0=;
        b=Rm84MPPkujjuan8nmZsDOSQGdqnNxRaGzj8v/aLpQIcmcFsVVvokCsuJjCmwPHEoFm
         5qPk2RUAhucciSZO/T2ndNQeGQoBe4q5PRHgUnuLSXklDfHoGLOkHscZb9EBEj+rHYwK
         uyr137aQRXCWEALZpvfGV2s63HMakrfT44mbkR1uRg8bqHTiqNjf9CPx4MAhqd4STJLo
         dYpxO7x6rKrCDzXDaQQBHHUahgOOJFXHCutYsWbM6e5CDqDVKjk76h69qJjsYWdJgggE
         0espYvlXVcPW67N6ViydCckaUuObad5zxoeKUheTSEVcpijGaqI+gEqgPtHt6H+m9i+5
         UEBQ==
X-Gm-Message-State: AOAM531cm3f2I1veOW/gjk4EUVsEuCXDnv6Th2G31azl32e0fvPHd/31
        pT6TZFfyHQFgaIxyWO9wV1hSG3wM
X-Google-Smtp-Source: ABdhPJwvKK+zNmouhE1GaJQ/7eY23PxXYX+9Lb+Ocbwc44jtTyDnTwWpNHVswyeX8MIswlnZkJrYNg==
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr10244448ejh.59.1595918426508;
        Mon, 27 Jul 2020 23:40:26 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id sb3sm5001981ejb.113.2020.07.27.23.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 23:40:25 -0700 (PDT)
Subject: Re: [PATCH] tty/synclink: remove leftover bits of non-PCI card
 support
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20200727130501.31005-1-hch@lst.de>
 <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
 <20200728062045.GA20992@lst.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e64a0045-02b5-777f-a60b-daa08dec04de@kernel.org>
Date:   Tue, 28 Jul 2020 08:40:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728062045.GA20992@lst.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 07. 20, 8:20, Christoph Hellwig wrote:
> On Tue, Jul 28, 2020 at 08:05:36AM +0200, Jiri Slaby wrote:
>> On 27. 07. 20, 15:05, Christoph Hellwig wrote:
>>> Since commit 1355cba9c3ba ("tty/synclink: remove ISA support"), the
>>> synlink driver only supports PCI card.  Remove any leftover dead code
>>> to support other cards.
>>
>> So now you can remove also the defines and bus_type completely:
>> $ git grep -E 'MGSL_BUS_TYPE_(E?ISA|PCI)'
>> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
>> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;
>> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_ISA 1
>> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_EISA        2
>> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_PCI 5
> 
> This is in a uapi header, so I didn't dare to touch it.

Ah, sure. Then OK.

Just wondering, who would place this into a uapi header?

>> $ git grep -w bus_type drivers/tty/synclink*
>> drivers/tty/synclink_gt.c:      unsigned int bus_type;
>> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
>> drivers/tty/synclinkmp.c:       unsigned int bus_type;
>> /* expansion bus type (ISA,EISA,PCI) */
>> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;
> 
> Despite the similar names these are actually two drivers entirely
> separate form the main synclink one.

I know, but it's set-but-unused field in both of them. So if the defines
went away, this could go too. But given the defines stay, it doesn't
matter. All 3 drivers are old unmaintained crap anyway:
$ git log --oneline  --no-merges  drivers/tty/synclink*|wc -l
79

thanks,
-- 
js
