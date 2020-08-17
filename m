Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F224790D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgHQVrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:47:06 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34709 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgHQVrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:47:04 -0400
Received: by mail-il1-f196.google.com with SMTP id t4so15872965iln.1;
        Mon, 17 Aug 2020 14:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0IjbqSR7n8dwKiCZAlHG0n3ZZFd//DhI57E3MhdcDB8=;
        b=Tq5auwkQWUG2+ZAmbcPIu8nvuWja+CJ3FFSv+KExzewe6qgJqhRXBYuVfBj/sT2OLa
         cUbHcmTOzYGMXLfDgM+ORqqEebpXRdir5PBvgCB7UkpuYH9DTQLe/Te7FSR7GFN2U3IK
         oJlKJJ/xnYgU4zPyc/giv0ybU4Ht5lfiTWTOnZTUjmqPiI4FwQvzmB9hJbpOqQo3U29B
         TEJAuQxcHqrEmh4A3EXUWhFSl/y+peoBHqq70x+EqGO+F1t88bpi8pULPl5ZTEEmkcAm
         +hw726cp1Y5wv4pDr6nJxLkqR5xA/3uCAvEMsdsfTQfrEn0ukj5recL3txngJ2wkbp8p
         z4qA==
X-Gm-Message-State: AOAM531qk4/Ud5SiGhIHPDkxXucZg0NHEOsxchNczatbKGoN+mLCSa5n
        fEDzH/zrmo7Xk2x21sI1Vw==
X-Google-Smtp-Source: ABdhPJwemuxUItv9uklxNA+c+9GTeWnEAEzWz7eGcjRVkLiwrv6diPZMqHw/ZZ3mu+HKdhkUay5P1Q==
X-Received: by 2002:a05:6e02:cb0:: with SMTP id 16mr3765217ilg.147.1597700823027;
        Mon, 17 Aug 2020 14:47:03 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t88sm10733892ilk.26.2020.08.17.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:47:02 -0700 (PDT)
Received: (nullmailer pid 1627315 invoked by uid 1000);
        Mon, 17 Aug 2020 21:47:01 -0000
Date:   Mon, 17 Aug 2020 15:47:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, Linux-imx@nxp.com, shawnguo@kernel.org,
        axboe@kernel.dk, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: ata: Convert i.MX sata to json-schema
Message-ID: <20200817214701.GA1627254@bogus>
References: <1596611746-29155-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596611746-29155-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 15:15:46 +0800, Anson Huang wrote:
> Convert the i.MX sata binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/ata/imx-sata.txt | 37 ----------
>  .../devicetree/bindings/ata/imx-sata.yaml          | 81 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-sata.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/imx-sata.yaml
> 

Applied, thanks!
