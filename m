Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736872FC718
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbhATBrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:47:37 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42183 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbhATBpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:45:36 -0500
Received: by mail-ot1-f43.google.com with SMTP id f6so12652918ots.9;
        Tue, 19 Jan 2021 17:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4zFLIX6YbpN5aLim6yrRCBFClVwkiMJYaqWYmkOOPrQ=;
        b=ilOxwK0IkK4JzQDbT9lqRPExZvUnT8UCT+yejraADgL+HLvaVpCbrkUlbKLtfrUrHd
         bTo99MByXRqsfNwJLSUZRkM6y/IKtA8QUKpbVIezDUg795d1w7yQhyF3CTTT5dAYX8cj
         V/MD9ZAg+3zIzSob2+/1WwEmaa9uvLLZHggrbmswlNYqEz2K8DjJ4Wm4BuMW7oeA02qW
         ydmrTX5wsH+tFIq3v69yYfPYeitAHvAdWnZ5NSjwokQUAjhk8LKFki89SbaEwY83E+In
         7BOF6jWDfuAEvhpx+1Ms5OJVCSCLH4lewbO5rDHU8tHExhaX08pksEa8CRbmGAk5eCtZ
         K7aA==
X-Gm-Message-State: AOAM530pLak8BuScDdCYpu5Y+gbcYfnr3hmvhKDlC2mZWJ6rtk+MFGu2
        SWLXBZs4nvJKc6lYwibolQ==
X-Google-Smtp-Source: ABdhPJzNzLwDdCRWb7mfJZPjC5yXOTPWn6hRch00Trm6xqHb+giSCQZAzkcjk4lDkIWsGAcxhvOK9g==
X-Received: by 2002:a9d:313:: with SMTP id 19mr5381524otv.147.1611107095736;
        Tue, 19 Jan 2021 17:44:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s24sm99037oij.20.2021.01.19.17.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:44:54 -0800 (PST)
Received: (nullmailer pid 3016866 invoked by uid 1000);
        Wed, 20 Jan 2021 01:44:53 -0000
Date:   Tue, 19 Jan 2021 19:44:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: powerpc: Add a schema for the 'sleep'
 property
Message-ID: <20210120014453.GA3706951@robh.at.kernel.org>
References: <20201008142420.2083861-1-robh@kernel.org>
 <752e9355-defb-6d3c-248b-f626247d4cee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752e9355-defb-6d3c-248b-f626247d4cee@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 05:10:03PM +0100, Johan Jonker wrote:
> Hi Rob,
> 
> This patch generates notifications in the Rockchip ARM and arm64 tree.
> Could you limit the scope to PowerPC only.
> 
> Kind regards,
> 
> Johan Jonker
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml
> 
> Example:
> 
> /arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dt.yaml: pinctrl:
> sleep: {'ddrio-pwroff': {'rockchip,pins': [[0, 1, 1, 168]]},
> 'ap-pwroff': {'rockchip,pins': [[1, 5, 1, 168]]}} is not of type 'array'
> 	From schema: /Documentation/devicetree/bindings/powerpc/sleep.yaml

IMO, the node name should be changed or just removed. The grouping 
doesn't serve any purpose and changing wouldn't break the ABI.

Rob
