Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969512FD970
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392312AbhATTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392384AbhATTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611170312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsvL74Qxz17lQJ/NGZiDcF3iJD33vJCVXTJiwPyT7Mc=;
        b=Picoh/rC/SHVelEMWzSf3WHt4+CtBXHE/FGub54v4dspkZho0aZyF/2c0Q5oAY31rzx15t
        /K5eaLxjVq2Iah5x45I4pRxls+AP1rrFkruoNE1inKEndwMy+XYzwoLefAOBGqDpTKSWR2
        dJDgW/1I2cm1Oewvc4glC1GHw1xL2cc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-nKiyjY50P1eGftoBY5aFyA-1; Wed, 20 Jan 2021 14:18:28 -0500
X-MC-Unique: nKiyjY50P1eGftoBY5aFyA-1
Received: by mail-ej1-f72.google.com with SMTP id z2so3489143ejf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsvL74Qxz17lQJ/NGZiDcF3iJD33vJCVXTJiwPyT7Mc=;
        b=tB2CDzIE0MuN2Goc/osNoDbHaO5EanIbJAukExbGKm63n5+QKff25lQE77M6iu+kzJ
         9yd5AIjZQ95ixAFJ2yjYkoXI/hHOYfaYw3JBebIcLv7gNnJ6oHem0HEdj2Q4TSNbsa04
         u+Coo9zNt44K/Az2+ElUhjlhYdGlVZndh0HFxOWMelbRq6A7f7Aw0Hvdz8mAjSDGHtVw
         X4JXoqMfLAGAwcxSzjH7s8r52GJqotbYjsGrVpNYmmE2DvDY/6UdU+wCqB4xSBMlODiU
         59wEq9juOS2BxdXQw+CnNaROC9OM0K0pOQag5zPTMO6h/AiKvGvJujTijH8kFsoCuNN0
         yvTQ==
X-Gm-Message-State: AOAM531u6zDLVAGrmQbsoouEn2bP4Z1rYL8cIQyDRjDZNwLkNKfRg0OC
        8Zr3x6QiaRf9fo8UmyMBVlg/tuUKgnt8+NnT9UXhLVTdIboQYDK8/SPKql7nYxFnETIcW79mPwu
        XBy3wCNj+SdLnrFCKHCg4JNBs
X-Received: by 2002:a05:6402:1c0f:: with SMTP id ck15mr8217261edb.171.1611170307516;
        Wed, 20 Jan 2021 11:18:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUs3bVZ7wa5D69mYTpMiyz86Ia5HOh0NKAlbuAPRTWWcXiP8JmNIqNlHEdqtmppW9EYLHlzw==
X-Received: by 2002:a05:6402:1c0f:: with SMTP id ck15mr8217248edb.171.1611170307336;
        Wed, 20 Jan 2021 11:18:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id h16sm1606315eds.21.2021.01.20.11.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:18:26 -0800 (PST)
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org,
        Christian Hartmann <cornogle@googlemail.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk>
 <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
 <20210118133449.GL4455@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a1ea81b6-8aff-274c-f1b2-a06a27650b25@redhat.com>
Date:   Wed, 20 Jan 2021 20:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118133449.GL4455@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 2:34 PM, Mark Brown wrote:
> On Mon, Jan 18, 2021 at 02:13:50PM +0100, Hans de Goede wrote:
> 
>> More in general I'm not aware of any (recent-ish) x86 GPIO controllers
>> not being able to do active low interrupts. In theory we could hit this
>> code path on ARM devices using ACPI enumeration, but I don't think it
>> is likely we will see a combination of ARM + ACPI enumeration +
>> WM5102 + GPIO controller not capable of active-low interrupts.
> 
> I've not seen this issue on any ARM based systems.
> 
>> This overriding of the flags definitely is necessary on the Lenovo
>> devices in question. I could add a
>> "if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
>> seems unnecessary.
> 
> Possibly just an update to the comment to make it clear that some
> firmwares might legitimately set the flag?

Ok, I've extended the comment above the override of the irq-flags with
the following paragraph for v4 of this patch-set:

         * Note theoretically it is possible that some boards are not capable
         * of handling active low level interrupts. In that case setting the
         * flag to IRQF_TRIGGER_FALLING would not be a bug (and we would need
         * to work around this) but sofar all known usages of IRQF_TRIGGER_FALLING
         * are a bug in the boards DSDT.

Regards,

Hans

