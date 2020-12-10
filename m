Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D882D5201
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgLJDsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:48:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33176 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbgLJDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:48:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so3655837ots.0;
        Wed, 09 Dec 2020 19:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7LvVqs5ncSD4pl3VnfXv2RU1ugwx7nqGrx68QnCprxg=;
        b=NxDg0b+gf74Kg9BGx3v4tjwLg754sucp3JsBpG69LsM82HPlpfZr3hl46qup/L+TwX
         IyZgo3Cy8I0CRyAhOFHoOBbODKTUCf3OrM5iFltv2mxmzFKDUjzU9iqYAfF7ttrVzibx
         0ZLdITE0YMY6PcNEokT3K7HHnW1yWIM7TbYZ2yPEsXJFjmG+a3xgaGkRF/Mooc7b43qf
         NnevePfqlF3UGRlwjDbqUcTZZowz5yODld/teg9Il/0Bw3ctShkzOtG2fSK0oZTwbovU
         8uIjpbtrKwoN8ItSgFFEq0fpF+h+dR8yAK+Luo3ycHhCQU8EL17llgKaGAlAtsC0UXbA
         wiRQ==
X-Gm-Message-State: AOAM532qPZQaahN7+wiAsXZLAhTQ4FE0I3/nViX+18WeclxmM1p8DDmp
        zO0r2/O668OLJGw6/iDSZg==
X-Google-Smtp-Source: ABdhPJyCfuLosZZ/+ky1293Ud30jc/f36KYY799wDDhYaMnz2bboZStpC5fYnkxw+auMputWawaGfQ==
X-Received: by 2002:a9d:774a:: with SMTP id t10mr4470692otl.190.1607572071320;
        Wed, 09 Dec 2020 19:47:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm783811oom.3.2020.12.09.19.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:47:50 -0800 (PST)
Received: (nullmailer pid 1621961 invoked by uid 1000);
        Thu, 10 Dec 2020 03:47:49 -0000
Date:   Wed, 9 Dec 2020 21:47:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, mripard@kernel.org,
        sean@poorly.run, orsonzhai@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, devicetree@vger.kernel.org, zhang.lyra@gmail.com
Subject: Re: [PATCH v1 1/6] dt-bindings: display: add Unisoc's drm master
 bindings
Message-ID: <20201210034749.GA1621931@robh.at.kernel.org>
References: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
 <1607352626-26088-2-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607352626-26088-2-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 22:50:21 +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
> 
> The Unisoc DRM master device is a virtual device needed to list all
> DPU devices or other display interface nodes that comprise the
> graphics subsystem
> 
> Unisoc's display pipeline have several components as below
> description, multi display controllers and corresponding physical interfaces.
> For different display scenarios, dpu0 and dpu1 maybe binding to
> different encoder.
> 
> E.g:
>   dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
>   dpu0 binding to DSI for primary display, and dpu1 binding to DP for external display;
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../display/sprd/sprd,display-subsystem.yaml       | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
