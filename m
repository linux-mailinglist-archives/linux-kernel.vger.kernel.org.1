Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEBC21AB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGIXSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:18:48 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44260 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:18:47 -0400
Received: by mail-il1-f196.google.com with SMTP id h16so3488486ilj.11;
        Thu, 09 Jul 2020 16:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GgSJ6lifAdWQh+4EB5RPcpMngcLOYnzzR45I4WP6SnY=;
        b=DOhyduOxs8d1sTDlzsNhRa6y1jXhB1EbjV8Jy90ycU0nA5arbZOgQUw2E54b8BBhyP
         Em+uPUhSPAFiH6JgwdOV4FjiGu5DiegWDBLtvk9B9GksmxRjeu4byiJMOZwzLQ2IFOIv
         YrmqS87j6t5lKSdh8odZBT39kxawIjUGJU1a/PXkxOGaNS2hEU6AXAwv0l5UYq++SkmL
         AV+HFX6deq9cjx87n8TayF61m9v20eV6J02iix18DRO3akYAeAvLOdHYScEwsK8z/ib4
         7VYJsBvfW/TpCGBzztRiph0eOH1Nzk6SUrtnmyZMKLZVUcS30IJPK2yFTmZyT3iXBj05
         vJzA==
X-Gm-Message-State: AOAM530CD4HCbPzDHP1QCQdoTzoSEAmqZB6ujiyjE7H+JGQObLIxhqFm
        pOgZXwsxlbuVdwPtViVwaA==
X-Google-Smtp-Source: ABdhPJwXUA0rPbKWVKd+QQlFU+l61cIgkhVVNmACM+qDjQUQv27O3xMuTthZBSZcjALzywonBeZDNw==
X-Received: by 2002:a05:6e02:8e4:: with SMTP id n4mr44630814ilt.96.1594336726809;
        Thu, 09 Jul 2020 16:18:46 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id h5sm2445983ilq.22.2020.07.09.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:18:46 -0700 (PDT)
Received: (nullmailer pid 1082231 invoked by uid 1000);
        Thu, 09 Jul 2020 23:18:44 -0000
Date:   Thu, 9 Jul 2020 17:18:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     devicetree@vger.kernel.org, kishon@ti.com, nm@ti.com,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, t-kristo@ti.com
Subject: Re: [PATCH v4 1/6] dt-bindings: mfd:
 ti,j721e-system-controller.yaml: Add J721e system controller
Message-ID: <20200709231844.GA1082201@bogus>
References: <20200629125254.28754-1-rogerq@ti.com>
 <20200629125254.28754-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629125254.28754-2-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 15:52:49 +0300, Roger Quadros wrote:
> Add DT binding schema for J721e system controller.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
