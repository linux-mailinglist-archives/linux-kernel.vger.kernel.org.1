Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31122A6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGWFgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 01:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGWFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:36:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66DBC0619DC;
        Wed, 22 Jul 2020 22:36:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so2479385pgc.5;
        Wed, 22 Jul 2020 22:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tFcZGTVxEOvpoeXkUsiN4vBy9B3kLzwfdLU6/Bk7M20=;
        b=o5ZB3El9NmbYAUMnVLSF4MIKU/vBZ/hxFH6zt/eg3JEdcrIYxBDT5DdYf4FaDNM7tc
         HYHjiAVqeSntdb6shGkwKcnEkageOOeoE6zxzESicOczUGrZEhoT9DaQHtjx5/yB4OYY
         1OfErF+AkU8/UiZFKOriS/yecoTRi9lBcCUC/2ZIbRJXr9gJb3RmlQPOYZ41m93EV/vV
         5IpLOGY1BcxzSVSF8CQu+FUYZ9Top4dkOSr5fM3ywCobxPGrAjWg/PmOn0Kf5mKXlZJM
         +KDrpfzLSI7/vaIf0f5ZMCVlZlPjz80SNScDW+gU0Jy0JQX9zaLqvfvb7wJLkqaSg4DE
         Jotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFcZGTVxEOvpoeXkUsiN4vBy9B3kLzwfdLU6/Bk7M20=;
        b=YhSYjfClc9Uw+P3XUqBWsV1ZptSpwHGBCoHaJJlbW3irveS5WqA47eCATJnrjpmc6M
         5iqmcqu+CS5lwdberf55yQ0LAnqpywEVSHS/WTxWoIvt4yrAsGkodZpHIhamUepm+Qc8
         A30+xe5zHuvB4YUBYK9zwN8F8vceHnSYYorwWpoRP6VJChXVwgpc/VEErt1kUfN6Yv9I
         oM8Vi42YSO+Z2Oz+c8GU8taYNKhCeQLlhQlCIhWf4uRwWt1s7jCBQwB4nsiEIdN8RTp9
         HEezyc0IlDi7vbiMni/cY7c+TkCMNbWc990ARwwjC08RPM60eD3+jhVjp5k1e+v4M4aQ
         sDCw==
X-Gm-Message-State: AOAM533Gt/zHFzml6PkZVut7R/vYJZVMGigUooAo7VojSkaUk5or1cs8
        icTwGqpoK9zXa5j42l5mOpI=
X-Google-Smtp-Source: ABdhPJwFIlyfJWb07kcj58BziwubzU5I4KohZd4uiMgJMQI1YstOLbnS44kIKgEb1P7Wi4W5qBcaaw==
X-Received: by 2002:a65:6554:: with SMTP id a20mr2447316pgw.301.1595482572334;
        Wed, 22 Jul 2020 22:36:12 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id o128sm1414392pfg.127.2020.07.22.22.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 22:36:11 -0700 (PDT)
Date:   Wed, 22 Jul 2020 22:35:39 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Support configuring dai fmt
 from DT
Message-ID: <20200723053538.GB5476@Asurada-Nvidia>
References: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:41:49AM +0800, Shengjiu Wang wrote:
> Support same propeties as simple card for configuring fmt
> from DT.
> In order to make this change compatible with old DT, these
> properties are optional.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

For both changes:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
