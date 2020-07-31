Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7087234DBC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGaWqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 18:46:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37068 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:46:33 -0400
Received: by mail-il1-f193.google.com with SMTP id r12so26617967ilh.4;
        Fri, 31 Jul 2020 15:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gKmj/Dylt/Qrj7FttBiwBWLpRVij7YLXxeiS0YCtcnk=;
        b=aElFXcyAGHOxm9/VWoqw7di9XDyMAOcScogOF+Y2HtP/4U82Dj9PCc8FTVeZ6zEWZ/
         XF/FptKqOS1Iso0oTafM//adUO9Rr2sZQpwHtzNuDCgU5TltVvoyC+q/5wPHZWPJ2OWU
         qyJSyYqZJhLpZZxJ4wpiMmX33aPKiGkCqTOJm36DTzuciOiObmcKeLtSW8pzwVEHakIc
         GVT1VnRnwhkPqOfjaiH6xlk2hLh/Qhus4Sr9pTTz8oFHVrSkZem+ZHEO4kTbNsecAaFu
         BBKmlS3mWcI+a7uQzv5jy7/RoMvAc8Ht4EemqNK4Ah+S+HYMcK73n1MH0OlIbDi0n1fX
         1W5g==
X-Gm-Message-State: AOAM532llkMHO4lEBi+B5YLlog1HXVQ+2saDlruvLWkNGxd2xXahdDa6
        7UCQayh5DVA5OLHLhx+NVQ==
X-Google-Smtp-Source: ABdhPJxRcmXuwCCcaUz8xrbyVfE81NK4pII4CM989m5WpnwD5XSiFYqp3tOpnbPDr859vyrua6EJDQ==
X-Received: by 2002:a92:5f4c:: with SMTP id t73mr5972306ilb.118.1596235592713;
        Fri, 31 Jul 2020 15:46:32 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c14sm5663521ild.41.2020.07.31.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:46:32 -0700 (PDT)
Received: (nullmailer pid 949012 invoked by uid 1000);
        Fri, 31 Jul 2020 22:46:30 -0000
Date:   Fri, 31 Jul 2020 16:46:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] =?iso-8859-1?Q?dt-bindings?=
 =?iso-8859-1?Q?=3A_arm=3A_fsl=3A_Add_Y_Soft_IOTA=A0Orion?= board
Message-ID: <20200731224630.GA948782@bogus>
References: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596196808-5067-1-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 14:00:06 +0200, Michal Vokáč wrote:
> Add devicetree binding for Orion - new board variant in the Y Soft
> IOTA family.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
