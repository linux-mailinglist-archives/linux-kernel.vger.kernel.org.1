Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805702478FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHQVkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:40:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38172 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgHQVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:40:50 -0400
Received: by mail-io1-f68.google.com with SMTP id h4so19160618ioe.5;
        Mon, 17 Aug 2020 14:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bghgkTC3QVlfhz+LJ7oipPmUTJO6yuPbbxRpmVsdnE=;
        b=eA2bfqQQntMc6WwsnzLdLl21npJHiah7AIkFlaJDzQBxRguNYpKk0wWR/epr208feX
         P9E/xq7m9SYZAsnKekAkFcfTbRIwEuiMWwIvL2P5iMXVM+nLVYo/XZ67b0ZcJgLEnjmz
         dbati1eCLF2IdWrcn7RCAX2KeWlXRlC3PGGzB7hi2sDuZ8SgkX80HhbL/zW77smnnry2
         fCtnqt4UqAx7cBggnxD4pF1eHjUI2Ibh2OvVtjsCN0tJllNs3EIKYFsIGI5lzFzdffLW
         wMmPGillphGcFbobsOntCkv94/kxUOgnu0hUmOg+MkO2mXzfSOKh67t27Harnfq6HaR5
         eeLQ==
X-Gm-Message-State: AOAM531WPFtytJdJI2QPOa/jd6wcImNoRiWu5pf0jR4z8UC8pIIedSHr
        N02axcjAdjUi9hPx6nh6SQ==
X-Google-Smtp-Source: ABdhPJwbPRE+sMzi11nxyfp7Kz1CohPc5alkqZQLcuwKI4IykUPYGiNvawIvZxvQuZ0SQN2zZhSFSw==
X-Received: by 2002:a5d:9d8a:: with SMTP id 10mr14257463ion.195.1597700447934;
        Mon, 17 Aug 2020 14:40:47 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id u25sm9674214iob.51.2020.08.17.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:40:47 -0700 (PDT)
Received: (nullmailer pid 1617017 invoked by uid 1000);
        Mon, 17 Aug 2020 21:40:45 -0000
Date:   Mon, 17 Aug 2020 15:40:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com, Frank.li@nxp.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, will@kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        festevam@gmail.com
Subject: Re: [PATCH] dt-bindings: perf: Convert i.MX DDR to json-schema
Message-ID: <20200817214045.GA1616941@bogus>
References: <1596609387-23542-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596609387-23542-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 14:36:27 +0800, Anson Huang wrote:
> Convert the i.MX DDR perf binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ------------
>  .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 39 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
>  create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> 

Applied, thanks!
