Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221BA22A1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgGVWDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbgGVWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:03:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F19C0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:03:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so2001584pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaSJOjYxrri/7FmsO8ASKIWMQQUaS+fP22lTbIs6vnM=;
        b=dvmV07cXBvU6pa9JHOugLBmCAKGJXy4Xyt8SZxoUsDxFV9w3dSWHQf4J6HLa69AgJj
         0myf2mTZvNtY6UIVyfMdY/7IxQsANIuxGFColh431YPOU+jni/LEusYzTaW+N1xg6EAz
         IoDC+yzkEEFUg1qQ19d5uxvi6kFcJNaBQnZwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaSJOjYxrri/7FmsO8ASKIWMQQUaS+fP22lTbIs6vnM=;
        b=jrDwa6JX+BC/pYZVMNgUg3akA1sMPYNO+Oei4fAs89zrF0C4vIrVIi8dsM+vCVTaEs
         +MYAOQiRaZzwmlmK818NdSMdrvAeT7mDY0B2xSMWJ/alIi00YHiIEtGIW8Q6P7Z8oRao
         pboM3k/qF2SUzA+lEjaJ5YCGaY7DeoAwCLus6E5xdum94jjzjo7QXrKz18HmZud1HETK
         O2dCri2u2+eGCd24jgEtObVJrc/BH/Dw+KwaRTSPT+UB9eNIjsUWC2YL4oWZgV8+R3WT
         oIsapjKa7PvdnIVHsap6k3t+eS8SEh8aymGfDqu0863/sQJzGMVn80rtZK0GOOdUVj6O
         GReg==
X-Gm-Message-State: AOAM533K6lS0PwqXD52k6Jt3Uox57zPkLf+Gg/1big4obBEr2R2iOHdD
        1A3WsG0NS5XY6EXA28azCtb5ow==
X-Google-Smtp-Source: ABdhPJzYFIwq2FueKwSGHZWrGPt0BN+iM2QiUgijkXljAolj8IoZVaJFJqNqA1mLxhQ5Q+NyNkO8Cw==
X-Received: by 2002:aa7:9d9a:: with SMTP id f26mr1505287pfq.26.1595455384828;
        Wed, 22 Jul 2020 15:03:04 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id o8sm618049pjf.37.2020.07.22.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:03:03 -0700 (PDT)
Date:   Wed, 22 Jul 2020 15:03:01 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2 0/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
Message-ID: <20200722220301.GB2137556@google.com>
References: <20200720202243.180230-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720202243.180230-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, Jul 20, 2020 at 01:22:39PM -0700, Guenter Roeck wrote:
> The EC reports a variety of error codes. Most of those, with the exception
> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
> to Linux error codes to report a more meaningful error to the caller to aid
> debugging.
> 
> To prepare for this change, handle error codes other than -EPROTO for all
> callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
> -EPROTO reflects an error from the EC and all other error codes reflect a
> transfer error.
> 
> v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()

I did a rough grep to see what you might be missing:

  git grep -n EPROTO | grep -e cros -e '-ec'

I think cros-ec-pwm / cros_ec_num_pwms() might need fixing too? Boy, I
wrote that, but it sure ain't easy to read...(*checks watch*)...4 years
later.

Apart from the notes already made, I think the series looks good:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Feel free to CC me on v3, if you want another look

Brian
