Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E01BFD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3OMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:12:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34106 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgD3OMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:12:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id 72so5010798otu.1;
        Thu, 30 Apr 2020 07:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jH47In+vOUdDhR141TzeK3fOseWCLkJwCgk8ocB+Nqg=;
        b=IscGFxZXX0aO1iHkQjoehlGkxvkTfbuO6zdOixA8tnulQaxnHyopnsf0ZrfH9X/L7f
         87IioMKJbJQv49ielEQun1/WfAWf0wbcGCxMf4HVaFo1hFDFyXCBIwBxFJ2eFcA4N9/Q
         jJE2PxoiBpSlxet920kAjA6wqlVRWbFIp56B6O0QWyBn+cObeWK5C7HkbqRp3jGMG7AO
         wQGm6d6OCOQwbSa7zS1vnpVZjsw5qJUcG+GGFkJCf6J/Zk1gC9sd/D2F/6F+HfvRh3Em
         je2ZhZAvmCPkUePuDbwCkb9mxWvxRuNNkbIrP/rv2sQx4iFtYi0PCnlJAuyl6JN9hQn9
         x50Q==
X-Gm-Message-State: AGi0Pubpbp7ruJa1nHb4//LBrDKphzOCvnnTRKK72zIrWFdIB5lBSllt
        /Szg+8lDBbw/v4dj2Hzh3A==
X-Google-Smtp-Source: APiQypLv7dPcYnLvOBxawDrcOT6GdPYGYLv0pv1iAj9xySMQfpV0BT9bHrPNbBvohWgFiuFxrKS3Bg==
X-Received: by 2002:a9d:6d8e:: with SMTP id x14mr2775926otp.156.1588255944417;
        Thu, 30 Apr 2020 07:12:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l11sm1359815oom.15.2020.04.30.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:12:23 -0700 (PDT)
Received: (nullmailer pid 8701 invoked by uid 1000);
        Thu, 30 Apr 2020 14:12:22 -0000
Date:   Thu, 30 Apr 2020 09:12:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 03/10] dt-bindings: marvell,mmp2: Add clock id for the
 I2S clocks
Message-ID: <20200430141222.GA8657@bogus>
References: <20200419172742.674717-1-lkundrak@v3.sk>
 <20200419172742.674717-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419172742.674717-4-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020 19:27:35 +0200, Lubomir Rintel wrote:
> There are two of these on a MMP2.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  include/dt-bindings/clock/marvell,mmp2.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
