Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD129EED7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgJ2Oyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgJ2Oyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603983272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2B8ESx3Qkgg174WkgZxum9Jq8NvJ5VbQ8kTa3ijDSQ=;
        b=IAfjQLG3a+l8XHuHN1PEAzjiMMRI9LyfkHqkkXvYhZMAoSTpX3xQ83g1QiEr3MAaYC3uG7
        +J8Oo1xaWJ7mTMLk1GOnjgrUsQTd+fuEPCRs0r6guW+kWKF/wTCZbeXaiLTaYI9l1OLlJJ
        a7AvbJt1T5vWQ2NREyTGi3wutETguEU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-CUQ2tbkBNhireezNo8oIow-1; Thu, 29 Oct 2020 10:54:31 -0400
X-MC-Unique: CUQ2tbkBNhireezNo8oIow-1
Received: by mail-ot1-f69.google.com with SMTP id l8so1053136ots.22
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u2B8ESx3Qkgg174WkgZxum9Jq8NvJ5VbQ8kTa3ijDSQ=;
        b=bm+8S4LLIsVD2lRF6r6H66YzcjtHHhgG37ysnomxVemaUvgT/5pDthkaNtTwd0YYPF
         /hfOfW7cmhl1qnzGtJKf+h8Tbh/wWXh0WT6c9Gt2BchgVKE5Z3Rc3bMwvBwmssHwLleU
         Hgqpl2riOvAZ5dern6IwalYdqUYp5+5NiOMTqMOjhrIVgwiqaysMd6f0KDjyUgR0is4D
         AiKhf3nBTSAcnlLkakfQYBdlokGyNV3ZeCJ1sOrnGn02S8Rgyee54sgk4IujrCwpuNgq
         /v1mj44eJNiJQcfrUdu+aCMN7BkLTPRyOyckTC7Fz5HxpcKkgGHlU83ueTok8WIPJKyb
         ehQw==
X-Gm-Message-State: AOAM531s2iE7SVPR/8fXC11AfHHIWGaJJeLG4MXj37ryjiw/CScdit5f
        CFkD6z3Uz+69Yz4R0lkuIqRZ/byuRahnWqBk0nwzSdQe8x42MIg176EUbyhpTA5jVG59MiEJyEu
        e5ykP2/Snxwh5I3KWcjOvFPM5
X-Received: by 2002:a05:6808:9ba:: with SMTP id e26mr128044oig.101.1603983270422;
        Thu, 29 Oct 2020 07:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRaXWMpqfFf1Cl9gwk2vGF4covuwcFLqFvFx471Uw57Y7xr3H546rVzodSQDve2ptDRn10Pw==
X-Received: by 2002:a05:6808:9ba:: with SMTP id e26mr128027oig.101.1603983270189;
        Thu, 29 Oct 2020 07:54:30 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d64sm680303oia.11.2020.10.29.07.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:54:29 -0700 (PDT)
Subject: Re: [PATCH 30/33] docs: ABI: cleanup several ABI documents
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <700bedb2-d2c8-db23-9946-88c8b2bda296@redhat.com>
Date:   Thu, 29 Oct 2020 07:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/20 7:23 AM, Mauro Carvalho Chehab wrote:
> There are some ABI documents that, while they don't generate
> any warnings, they have issues when parsed by get_abi.pl script
> on its output result.
>
> Address them, in order to provide a clean output.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-class-dax    |   8 +-
>  .../ABI/obsolete/sysfs-driver-hid-roccat-pyra |   3 +
>  Documentation/ABI/removed/devfs               |   1 +
>  Documentation/ABI/removed/raw1394             |   1 +
>  Documentation/ABI/removed/sysfs-class-rfkill  |   2 +-
>  Documentation/ABI/removed/video1394           |   1 +
>  Documentation/ABI/stable/firewire-cdev        |  63 ++---
>  Documentation/ABI/stable/sysfs-acpi-pmprofile |   4 +-
>  Documentation/ABI/stable/sysfs-bus-w1         |   1 +
>  Documentation/ABI/stable/sysfs-class-tpm      |   4 +-
>  Documentation/ABI/stable/sysfs-driver-speakup |   4 +
>  Documentation/ABI/testing/configfs-most       | 135 +++++++----
>  .../ABI/testing/configfs-usb-gadget-ecm       |  12 +-
>  .../ABI/testing/configfs-usb-gadget-eem       |  10 +-
>  .../ABI/testing/configfs-usb-gadget-loopback  |   6 +-
>  .../testing/configfs-usb-gadget-mass-storage  |  18 +-
>  .../ABI/testing/configfs-usb-gadget-midi      |  14 +-
>  .../ABI/testing/configfs-usb-gadget-printer   |   6 +-
>  .../testing/configfs-usb-gadget-sourcesink    |  18 +-
>  .../ABI/testing/configfs-usb-gadget-subset    |  10 +-
>  .../ABI/testing/configfs-usb-gadget-uac2      |  14 +-
>  .../ABI/testing/configfs-usb-gadget-uvc       |   2 +-
>  .../ABI/testing/debugfs-cec-error-inj         |   2 +-
>  .../ABI/testing/debugfs-driver-habanalabs     |  12 +-
>  .../ABI/testing/debugfs-pfo-nx-crypto         |  28 +--
>  Documentation/ABI/testing/debugfs-pktcdvd     |   2 +-
>  .../ABI/testing/debugfs-turris-mox-rwtm       |  10 +-
>  Documentation/ABI/testing/debugfs-wilco-ec    |  21 +-
>  Documentation/ABI/testing/dell-smbios-wmi     |  32 +--
>  Documentation/ABI/testing/gpio-cdev           |  13 +-
>  Documentation/ABI/testing/procfs-diskstats    |   6 +-
>  Documentation/ABI/testing/procfs-smaps_rollup |  48 ++--
>  Documentation/ABI/testing/pstore              |  19 +-
>  Documentation/ABI/testing/sysfs-block-rnbd    |   4 +-
>  Documentation/ABI/testing/sysfs-bus-acpi      |   1 +
>  .../testing/sysfs-bus-coresight-devices-etb10 |   5 +-
>  Documentation/ABI/testing/sysfs-bus-css       |   3 +
>  Documentation/ABI/testing/sysfs-bus-dfl       |   2 +
>  .../sysfs-bus-event_source-devices-hv_24x7    |   6 +-
>  .../sysfs-bus-event_source-devices-hv_gpci    |   7 +-
>  Documentation/ABI/testing/sysfs-bus-fcoe      |  68 ++++--
>  Documentation/ABI/testing/sysfs-bus-fsl-mc    |  12 +-
>  .../ABI/testing/sysfs-bus-i2c-devices-fsa9480 |  26 +-
>  Documentation/ABI/testing/sysfs-bus-i3c       |   2 +
>  Documentation/ABI/testing/sysfs-bus-iio       |  19 +-
>  .../ABI/testing/sysfs-bus-iio-adc-hi8435      |   5 +
>  .../ABI/testing/sysfs-bus-iio-adc-stm32       |   3 +
>  .../ABI/testing/sysfs-bus-iio-distance-srf08  |   7 +-
>  .../testing/sysfs-bus-iio-frequency-ad9523    |   2 +
>  .../testing/sysfs-bus-iio-frequency-adf4371   |  10 +-
>  .../ABI/testing/sysfs-bus-iio-health-afe440x  |  12 +-
>  .../ABI/testing/sysfs-bus-iio-light-isl29018  |   6 +-
>  .../testing/sysfs-bus-intel_th-devices-gth    |  11 +-
>  Documentation/ABI/testing/sysfs-bus-papr-pmem |  23 +-
>  Documentation/ABI/testing/sysfs-bus-pci       |  22 +-
>  .../ABI/testing/sysfs-bus-pci-devices-catpt   |   1 +
>  .../testing/sysfs-bus-pci-drivers-ehci_hcd    |   4 +-
>  Documentation/ABI/testing/sysfs-bus-rbd       |  37 ++-
>  Documentation/ABI/testing/sysfs-bus-siox      |   3 +
>  .../ABI/testing/sysfs-bus-thunderbolt         |  18 +-
>  Documentation/ABI/testing/sysfs-bus-usb       |   2 +
>  .../sysfs-class-backlight-driver-lm3533       |  26 +-
>  Documentation/ABI/testing/sysfs-class-bdi     |   1 -
>  .../ABI/testing/sysfs-class-chromeos          |  15 +-
>  Documentation/ABI/testing/sysfs-class-cxl     |   8 +-
>  Documentation/ABI/testing/sysfs-class-devlink |  30 ++-
>  Documentation/ABI/testing/sysfs-class-extcon  |  34 +--
>  .../ABI/testing/sysfs-class-fpga-manager      |   5 +-

The fpga-manager change looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>



