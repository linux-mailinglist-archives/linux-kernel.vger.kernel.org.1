Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A75298EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780880AbgJZOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:01:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42443 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780870AbgJZOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:00:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id c72so1162770oig.9;
        Mon, 26 Oct 2020 07:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pG/9G2wHZKjQaOLnT3vSPF5oyrBjZ7juAO9aLYBUT1w=;
        b=V3LMea63jn8rzLiplabmZG6NU3Xw6N/OFAJ31hr99bpAOJq3hJa5axopx1YuuiT6VS
         /LmseEkdrXhW3IHdZ9NI5EfuTBINGRkRJ0/70ktm9ZWm8AwCfJwoordHhLYaUZANBhGS
         LFjou0nae+mvP8SNn8QN2LC92/vPuffbsbNGfq7eel90yeTV20AnQUhHALXi8vG4iBeZ
         bQJHfWo2W4JrvfZqzmq1yJURrst4h7k3pt+UwjUqd/HIaD0+OGL+Rn7M9MGNjZwWSwbP
         KpagUtN/nacCfQ4VeA3p69890zRMzyEVWnY/CvE0IhzWjTZbd9oy5JGJLLXjXWNqGPpl
         fydg==
X-Gm-Message-State: AOAM533kmRlpx8xK0eepmDmVyn+jejFhQSBg+4zS+vAC3w7pEBlv4sLk
        W5IFrd4abXRz8uiJ78s3jupiHL3NVg==
X-Google-Smtp-Source: ABdhPJwn+Ve27BSpW3nxAtoP8gce2Vj4YxzDnsNpZoqeACCTOBKA8PL5AzZu8NUmFTMVsuMOzyYcww==
X-Received: by 2002:aca:be56:: with SMTP id o83mr14057156oif.1.1603720858647;
        Mon, 26 Oct 2020 07:00:58 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p10sm3992214oig.37.2020.10.26.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:00:57 -0700 (PDT)
Received: (nullmailer pid 73839 invoked by uid 1000);
        Mon, 26 Oct 2020 14:00:56 -0000
Date:   Mon, 26 Oct 2020 09:00:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v11 01/10] dt-bindings: connector: Add property to set
 initial current cap for FRS
Message-ID: <20201026140056.GA73720@bogus>
References: <20201020093627.256885-1-badhri@google.com>
 <20201020093627.256885-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020093627.256885-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 02:36:18 -0700, Badhri Jagan Sridharan wrote:
> This change adds frs-typec-current which allows setting the initial current
> capability of the new source when vSafe5V is applied during PD3.0
> sink Fast Role Swap.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
> 
> Changes since v6:
> - Removed the redundant usb-connector.txt that I created by mistake.
> - Moved to yaml.
> 
> Changes since v7:
> - Rebase
> 
> Changes since v8:
> - Redefine new-source-frs-typec-current as string enums to address
>   Rob Herring's comment.
> 
> Changes since v9:
> - Removed FRS constants from usb bindings.
> 
> Changes since v10:
> - Suggestions from Rob Herring:
>  - Going back to u32 for new-source-frs-typec-current
>  - Removed the definition for "not-supported"
> - Bringing back FRS constants for usb pd binding.
> ---
>  .../bindings/connector/usb-connector.yaml     | 19 +++++++++++++++++++
>  include/dt-bindings/usb/pd.h                  |  8 ++++++++
>  2 files changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
