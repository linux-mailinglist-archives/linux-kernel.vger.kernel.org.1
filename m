Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4861A99A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408445AbgDOJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895884AbgDOJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:49:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so5116442wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GKKVZB6d9uj7AM5ifWQ/7HPxejyrFCZAcE0q5IaGck8=;
        b=imaYsFi9xQ4gjZTtk5imLh3tRJzoLf466PZog1BfzYZPj5664XwHAWgcND95yHzApl
         ME0lW41tBiJEH5SiUbsF7UpktYy+MQa40KnW30gQlWAHOMi2UL+1CaAVNNyJHQIAXDf4
         XbToncIkamK0aX4JsZwRTQ7gwgF8LZEmq0smftrW4Ijv8frb2AxYeBWEmgD1sT4/02G8
         6ZfrIhDZdUhW4bIQJYZpaiqGvYxM1oYK6H0buPPVXsC6LxKgRjsPHweVDg/QT8ND/66W
         aaiinfLKK9jXuTWHOOT+zMf8SSNnSgAtQ0Jpw8c+FoH7V+ZioEMObTDdPcA7zw0kXoEn
         6EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GKKVZB6d9uj7AM5ifWQ/7HPxejyrFCZAcE0q5IaGck8=;
        b=a00fW6k3o6s0vSCQL+wwFgrz54Pysby7GuEoimIZ7Rs2Ul5MzxQ9nmnJqH+ICmMDZG
         2WKj4CDanPZ5/UaIy83UoT5HBWQnu/Vz3cvTaoFGMef1lXP6vOSgI/CWnj4eLhxy8oJw
         5x8iB1LQn35yc17zGk2iuqJXBg1XOveKwn15ZO4CTNkLx3NRnIj66u9QSWNeX4qwm7MY
         e3Ny+aoxVaLwBh74XhnlwI2qGQjSFnrmHFnZaMivUCIDRNPygX8aJKeXxCvHbBTSoilF
         Ojy+Q/+pAbGdLTBVuHL1s0NUljKYDlZay9We2Z+6llS1BzjSdGaT6vochwvxhVrF1tLT
         N0aA==
X-Gm-Message-State: AGi0PubzIEj8s9th+CMr6VV1Y27SlUPa62vlHe4VcrBiQrPzoWykX2Dh
        37vZ9/hK8jZMC2Pc7WX0hBjrpA==
X-Google-Smtp-Source: APiQypJke9uVeGjVaPGK5i9IV5JUW01AEz700Dq1p4629GpCAn0jYGnmmg1HqIeXaWUn+LD8VbWGQA==
X-Received: by 2002:a5d:4042:: with SMTP id w2mr19615908wrp.195.1586944191413;
        Wed, 15 Apr 2020 02:49:51 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id w7sm23027209wrr.60.2020.04.15.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:49:50 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:50:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Message-ID: <20200415095052.GI2167633@dell>
References: <20200326064852.GA23265@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326064852.GA23265@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Matti Vaittinen wrote:

> ROHM BD70528 and BD718x7 drivers do not utilize the I2C id.
> Do the trivial conversion and make them to use probe_new
> instead of probe.

Not sure I understand the purpose of the patch.

The only reason to switch to probe_new is to aid the removal of the
compulsory I2C tables.  However, neither of these drivers have them.

> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/rohm-bd70528.c | 5 ++---
>  drivers/mfd/rohm-bd718x7.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
