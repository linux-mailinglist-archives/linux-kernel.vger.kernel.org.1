Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F3296C52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461700AbgJWJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:47:08 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:45966 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461692AbgJWJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:47:08 -0400
Received: by mail-ej1-f65.google.com with SMTP id dt13so1475496ejb.12;
        Fri, 23 Oct 2020 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dle8MfevTYw4HxOBkbBF4RWtrsDKeoGEvEwmzDZe1U=;
        b=cYqvbG2OxwfbzyL6TIu+8DihESTPokr03Ej8C7SOtIGQNIHaKpntQQn+XOh92NxhGw
         7akn1sVrxrMH2EJQd01p2dubcMnbk/CdsMyOf0HHgjVtSlR335pjikwDUgI8lrmWRVau
         yR54nZtOLhoKOGVI0FTtOVT6195ia33hhQ960cFIHx1zUfomcgoCpoUu7jesp7LqgKVi
         IsOOAizi/Xx858+CFF6xULAlW2WReSJbDDVMVlo9KGOKFIUSim+e0roSqvwUAs0LrHyG
         fU1aLzx5lNAGlrTI8PQZZtreUhC0XT2ceVW8g7k9H/PlxyACQU5Gsfx9gVHixHBUuaT8
         BimQ==
X-Gm-Message-State: AOAM533eeJGXoQYuhnb9adMI8OIVbcYZqw9SAP03tMe3SR0I5/tqQVMr
        8ja9Q2B2AbKJr2HagZk+sJAEdjvufsQ=
X-Google-Smtp-Source: ABdhPJxG37WM83zzqlm5SZAZ+gBfrEFGfyk/6CDh0x3CW/zL0zEdOrVHiPKspjLas4qlGPw0jmi2jg==
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr1125765ejq.112.1603446426353;
        Fri, 23 Oct 2020 02:47:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id bx24sm509757ejb.51.2020.10.23.02.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:47:05 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:47:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marex@denx.de,
        l.stach@pengutronix.de, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] soc: imx: gpcv2: add support for i.MX8MN power
 domains
Message-ID: <20201023094702.GD42872@kozik-lap>
References: <20201022150808.763082-1-aford173@gmail.com>
 <20201022150808.763082-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022150808.763082-3-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:08:05AM -0500, Adam Ford wrote:
> This adds support for the power domains founds on i.MX8MN. The Nano
> has fewer domains than the Mini, and the access to some of these domains
> is different than that of the Mini, the Mini power domains cannot be
> reused.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
