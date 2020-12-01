Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408C82C97EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgLAHQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:16:48 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43556 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgLAHQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:16:48 -0500
Received: by mail-ej1-f67.google.com with SMTP id jx16so1942547ejb.10;
        Mon, 30 Nov 2020 23:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j9ll6iRV/I8KyPiOm524mGU27EsQLs+Mz5PTBeyjZVE=;
        b=VSqdTF5gVa/PNEw02m5Ozemx/LEiPuXPWU+npaEJ/31bP4zd83UcjKAy7ZeS3xPpo3
         yN8qHspnjB76kfK79762zEtmGjXZAZXfdSOzI7fOzc13kRg9TLRKG7YNjjeQj3EFZ26o
         jWr2VuSbCCR4PXl90JrQwUcSY70wiedc1oFjlqETfacuO+AuBL/A/5NjNLGHYiXigYi1
         CcgsiEcmyUZhifUAXhbd/vIGI2txHpALmFAwHugQFNufkq+/ja1eDEq98ifjLECE/xtc
         o7QOAfOZoPRrKN9htN+PPyLLb2dxqAM55nu69WNeFos79H2ipG177sL7B/xx/o2jrExM
         CApA==
X-Gm-Message-State: AOAM530NrT9nP6Tg2Y7OsyMO2TVqCf5JrfWDF7MMh4DptCFlDojTRcTV
        ZvY141/fZVC3aSl1S6o5GXMCcvCOpY8=
X-Google-Smtp-Source: ABdhPJz2xIbEprKxuJpgQgtgzfsyNrdD7/w5qpeU0JZp8sHfY2prNlB7cONrN6gcOctBb5gvphjRbg==
X-Received: by 2002:a17:906:ad4:: with SMTP id z20mr1710672ejf.546.1606806965691;
        Mon, 30 Nov 2020 23:16:05 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id b14sm331616edm.68.2020.11.30.23.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 23:16:04 -0800 (PST)
Subject: Re: [PATCH 1/5] tty: add port flag to suppress ready signalling on
 open
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201130153742.9163-1-johan@kernel.org>
 <20201130153742.9163-2-johan@kernel.org>
 <ffec9dbe-a238-4411-acdb-41bd33719288@kernel.org>
 <CA+uuBqa-k0Ztt18cetCdYs=6tBk8xTHufaFAcbpA3wert8nFAA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <aa22e64e-9af1-97b4-83af-26c130870750@kernel.org>
Date:   Tue, 1 Dec 2020 08:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+uuBqa-k0Ztt18cetCdYs=6tBk8xTHufaFAcbpA3wert8nFAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 12. 20, 8:09, Mychaela Falconia wrote:
> On 11/30/20, Jiri Slaby <jirislaby@kernel.org> wrote:
>> port can be const here.
>> [...]
>> We have assign_bit() for these cases these days.
> 
> Johan's patch adding test and set accessor inline functions for the
> new flag follows the style of the existing accessor inline functions
> for previously existing flags, for the sake of consistency. If we are
> going to use the new style (const for test functions, assign_bit() for
> set functions) for the new flag, then we should also change all
> existing ones for consistency. In terms of patch splitting, would it
> be most kosher to have one patch that updates the style of existing
> accessor inline functions, and then the interesting patch that adds
> the new flag?

Yes. Or the other way around. Add this new using const+assign_bit and 
convert the rest on the top of the series.

thanks,
-- 
js
