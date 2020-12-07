Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7CD2D131B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgLGOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgLGOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607349979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIQEZStG8ElOQdQ6wrva4lMkvQcBMuWnarU5vOcVQdQ=;
        b=Le9oCxg1lOldRkdj5Cf2WcnTCXQCimk0niJPsM3cdePEBUmX+XTEvwEtit14229GhidAvM
        7mCScHGZg11iw86T4JeJ7XlSviU1uojBpg/DsEV7OKU63HyLA5ZOLjgzy161DjWrdI9kEC
        5BW/TBAq2/HRXTbbLQsLZGAlaltI7/0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-BKD3ZF7iPkKqB2N1gjGscQ-1; Mon, 07 Dec 2020 09:06:17 -0500
X-MC-Unique: BKD3ZF7iPkKqB2N1gjGscQ-1
Received: by mail-ej1-f70.google.com with SMTP id k3so389911ejr.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oIQEZStG8ElOQdQ6wrva4lMkvQcBMuWnarU5vOcVQdQ=;
        b=TKd0EWVuyJidDat4mnxsP8xfR/uSxyuiYLfwHSr7Vhsqo1cYCj3kBiCs/r5oX7MuGD
         yaiSg8FeF15+UNCEpOx3QSh2e6XFeZw6FpXmprBRUyj4m0+mBuJPHTa7nknIkH80QoHR
         Th2KCnUVcxoOU/+VU7Df6y4Wj9I9RXxiWrr9jQ2RknziAe+vPAWnmMPxOdIAUY3SBGwG
         CRIDV5bf0FzHqfUyFQcTqr20E/USmBsg0Tpv6L18Rpy6jrdN68gXyCR6aUWjM9mad+iF
         oZ2s/J63JILSlUZVzJfMBbVjt6RXfOHG/pR6ryZc9flwvShjLDdPN5oMstUi5q2Qqzbh
         CECg==
X-Gm-Message-State: AOAM532pMpjjGvqO1XCgcSa+GYyRFjvQuBA+/hqi002vutn+6PA/Xm4G
        hfrvFlGGdQPAEZau+3zFLm9l8BIfm/ccGB5IZMt8SfXOtsxnSdeg46FB5uXBrWH5jyappwBIqtB
        tKrTNeM01XLjs8CiFgZ+oc9Cf
X-Received: by 2002:a50:d4d9:: with SMTP id e25mr9795388edj.243.1607349976230;
        Mon, 07 Dec 2020 06:06:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxghHQqy/Z3ozF+KzW4FFZXQMPRBxJdF5q4jLTmTzZsCzyRG416H05Zx7Uf+lIDd6n13A8Z5w==
X-Received: by 2002:a50:d4d9:: with SMTP id e25mr9795374edj.243.1607349976078;
        Mon, 07 Dec 2020 06:06:16 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v24sm13606696edw.23.2020.12.07.06.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 06:06:15 -0800 (PST)
Subject: Re: [PATCH] acer-wireless: send an EV_SYN/SYN_REPORT between state
 changes
To:     Chris Chiu <chiu@endlessos.org>, dvhart@infradead.org,
        andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Daniel Drake <drake@endlessos.org>
References: <20201207064322.13992-1-chiu@endlessos.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ce1eaef4-c804-c956-ce24-fa1333100060@redhat.com>
Date:   Mon, 7 Dec 2020 15:06:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207064322.13992-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/20 7:43 AM, Chris Chiu wrote:
> From: Daniel Drake <drake@endlessos.org>
> 
> Sending the switch state change twice within the same frame is invalid
> evdev protocol and only works if the client handles keys immediately as
> well. Processing events immediately is incorrect, it forces a fake
> order of events that does not exist on the device.
> 
> Recent versions of libinput changed to only process the device state and
> SYN_REPORT time, so now the key event is lost.
> 
> Same fix as 'commit <bff5bf9db1c94> ("platform/x86: asus-wireless: send
> an EV_SYN/SYN_REPORT between state changes")'
> 
> Signed-off-by: Daniel Drake <drake@endlessos.org>
> Signed-off-by: Chris Chiu <chiu@endlessos.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/acer-wireless.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
> index e0976180532a..1b5d935d085a 100644
> --- a/drivers/platform/x86/acer-wireless.c
> +++ b/drivers/platform/x86/acer-wireless.c
> @@ -28,6 +28,7 @@ static void acer_wireless_notify(struct acpi_device *adev, u32 event)
>  		return;
>  	}
>  	input_report_key(idev, KEY_RFKILL, 1);
> +	input_sync(idev);
>  	input_report_key(idev, KEY_RFKILL, 0);
>  	input_sync(idev);
>  }
> 

