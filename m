Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1725126ADCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgIOTlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:41:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35619 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgIOTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:40:42 -0400
Received: by mail-io1-f68.google.com with SMTP id r9so5488138ioa.2;
        Tue, 15 Sep 2020 12:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfEYrvgcOiUrQghArzmubEmT7dgVoxokSlA4Pccr+ZY=;
        b=i4zzmufcgdG1U42/Hvjhb6o9iPPlEyWrM+jg/KYcXQ1FvBUpyWYy6V5FB8udbi2hU5
         qntdpP/KCMlif8gcab2CfrFVaOjp4VqeyJvRgyw/uRmObVd/AdjMTROYFENXyDAwSZms
         cSJPxXcQsG9C/2OREBg/DM+Qm8efTx584GWQxwBZUuz0fO2M2NShYdnXbr4Hnr+zG/HH
         vV5EbvGZv9a39RqkePS3t946enz9/Pndh0hqnd/+cTXyUglp5zRFji4dUE1SnoNqYDIN
         dOinblTOL2W7tTfd9nKfvWAK037pAgyY+Hjy+YADIRVj/L6WcDHautM22snKHLzOZqgS
         0GBg==
X-Gm-Message-State: AOAM533lyHTf0/Ba8e1oQvAJ9jjxnC45cr8W9gzXrmQPv87GTMD99Ujf
        atq9LJ3nvd1WGATxlNvH/x75PwT91MR+hCY=
X-Google-Smtp-Source: ABdhPJzDB4o5XMy5QrZavFrfxZUetNl+70UR8W+YyXG9y/BnjSdmC8Czpn7UH/fsUZeasw0dEO7ckw==
X-Received: by 2002:a02:9f0d:: with SMTP id z13mr19175961jal.60.1600198840940;
        Tue, 15 Sep 2020 12:40:40 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m87sm9622553ilb.58.2020.09.15.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:40:40 -0700 (PDT)
Received: (nullmailer pid 2377450 invoked by uid 1000);
        Tue, 15 Sep 2020 19:40:38 -0000
Date:   Tue, 15 Sep 2020 13:40:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V3 2/2] dt-bindings: mailbox: add doorbell support to ARM
 MHU
Message-ID: <20200915194038.GA2377399@bogus>
References: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
 <5d448f579a41345130ae25d01bb94a6e293a6460.1599731645.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d448f579a41345130ae25d01bb94a6e293a6460.1599731645.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 15:25:19 +0530, Viresh Kumar wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> The ARM MHU's reference manual states following:
> 
> "The MHU drives the signal using a 32-bit register, with all 32 bits
> logically ORed together. The MHU provides a set of registers to enable
> software to set, clear, and check the status of each of the bits of this
> register independently.  The use of 32 bits for each interrupt line
> enables software to provide more information about the source of the
> interrupt. For example, each bit of the register can be associated with
> a type of event that can contribute to raising the interrupt."
> 
> This patch thus extends the MHU controller's DT binding to add support
> for doorbell mode.
> 
> Though the same MHU hardware controller is used in the two modes, A new
> compatible string is added here to represent the combination of the MHU
> hardware and the firmware sitting on the other side (which expects each
> bit to represent a different signal now).
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3: Update the json schema and fix number of interrupt lines.
> 
>  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 60 +++++++++++++++++--
>  1 file changed, 54 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
