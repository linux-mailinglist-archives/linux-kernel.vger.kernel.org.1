Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E32E0382
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLVAox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVAox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:44:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D13C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:44:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 11so7454107pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dt2YqyLI3s2gMHSwF8KuFlr09vBk3PGk/5wcFeVzQZc=;
        b=Q1eb7iFNX7sdTU7MkXZ7iMGL59AhKBL8COeOOQLtvlsxiku9AejnOtF9JVJzTElYjR
         Bz4/C/yMtK96vszdyros0onF8JoYLkZG5pSixDhfgSL8yub30SKoQ6q9kmLbUj1AM2CH
         b2AdaOfBclRYyxXZqNBmkjBnHzRPLPIkRIVX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dt2YqyLI3s2gMHSwF8KuFlr09vBk3PGk/5wcFeVzQZc=;
        b=lnjqjEpHVLZz4wpKTR8zaZKLvIfcJFouV1ppDDl61/7r4pgXyBsZl0RZP8auRoHpnn
         0r9p1LxRoDKOQFKUrazPnIU6PeAmgM1zFYfdvi9Fxj/EyrE0KU0znZZ74uS9QcR/Xg1y
         Ox/NjLT7Iy14Z5CCZVOD/kSDPUT+qDkAjnfNaNTFP6UD+xtVmzPImxWhVHoEiDsu2m5N
         E0rO/+/hC/1Z8YL7Avs28gEomr8m90ulnPcCdWo0r4AJvMjhbtAAlH2bCidLd+x3P+Xy
         SYhS4mPNHqGTx9eWbdd008143l+dds/XERB9/2Oi8BbtOJdTlCsnOR8OIQg83wfiMDvt
         S3pw==
X-Gm-Message-State: AOAM532QVaQbCLpnfQKczKllw2M//gRePQKcgIgppO8+WBTAD4HgxgQA
        N8vwStmU+nFi4ekHAXv7maRT8g==
X-Google-Smtp-Source: ABdhPJyPbmYvyff8pPDKCcQdCiwfHlYaOhcBtt7PBcvUjZevlce0iMJfs6xuEU4Komwg1GtTgJN7Qg==
X-Received: by 2002:a62:e213:0:b029:19e:59d3:a76a with SMTP id a19-20020a62e2130000b029019e59d3a76amr1986126pfi.53.1608597852153;
        Mon, 21 Dec 2020 16:44:12 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b12sm17486153pft.114.2020.12.21.16.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:44:11 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:44:10 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        rajmohan.mani@intel.com
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Parameterize
 cros_typec_cmds_supported()
Message-ID: <X+FBWkl5voXLPxuF@google.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
 <20201210060903.2205-2-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210060903.2205-2-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Wed, Dec 09, 2020 at 10:09:02PM -0800, Utkarsh Patel wrote:
> cros_typec_cmds_supported() is currently being used to check only one
> feature flag.
> Add a new feature parameter to it so that it can be used to check
> multiple feature flags supported in cros_ec.
> Rename cros_typec_cmds_supported() to cros_typec_feature_supported().
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

Thanks,

-Prashant
