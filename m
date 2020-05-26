Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B226F1CE361
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgEKS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:57:20 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36426 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgEKS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:57:19 -0400
Received: by mail-oo1-f66.google.com with SMTP id z6so1267743ooz.3;
        Mon, 11 May 2020 11:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9DDGxEg7vQSJEKOEBrEEwpWrhqYal1ymI5IJkhpthc4=;
        b=X4GXZyfOvwrmmUK0Wthb18MMiTob+s+JVMEnm72radC7fhOKjGa3XG0FNmlWQaJm+q
         FzfUofLsxFRdBFa7S0vxPao1QdK6w1FgzBYxYTcN9xCH1IwbXDUOKW+OK6MhkKWKbKF0
         ASlgk1XhjPTYw6/tEU+neA/uvkRSXEmOvYptJyjYR9Yxe+WjiCBsv/dWbR8SYHEdmlL5
         XMIVHvHvoZOqEdLiroWjHOpQ1V7pzO3CNrGnek5YteTRNYJa1yBCZ0qB0eKIr/mCtz3o
         r5XmeKmniOtjsFQr2dG7FWKgC0fjRrIl9YUQwfY5HhGnZ6iyUKUD6VPlhlSKFDnbQzh1
         Updg==
X-Gm-Message-State: AGi0Pub4JJqxSgZCebGovDuvQsDc+GdYVHks3ls+ctYCZXNNDJTi93qo
        htHC7DG7nQok6FinogYYig==
X-Google-Smtp-Source: APiQypLRAL/UCcvc18wlicYHZc/dKZIwLzEIrilbbYwAFq3D3D0Zv/+rcU2sOWQnEJrPT5FDFuas6A==
X-Received: by 2002:a4a:95d0:: with SMTP id p16mr2892621ooi.40.1589223438020;
        Mon, 11 May 2020 11:57:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f5sm3045488oos.8.2020.05.11.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:57:17 -0700 (PDT)
Received: (nullmailer pid 3280 invoked by uid 1000);
        Mon, 11 May 2020 18:57:16 -0000
Date:   Mon, 11 May 2020 13:57:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     kernel@pengutronix.de, festevam@gmail.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: Re: [PATCH V2 3/3] dt-bindings: nvmem: Convert MXS OCOTP to
 json-schema
Message-ID: <20200511185716.GA3229@bogus>
References: <1587478181-21226-1-git-send-email-Anson.Huang@nxp.com>
 <1587478181-21226-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587478181-21226-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 22:09:41 +0800, Anson Huang wrote:
> Convert the MXS OCOTP binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- drop clocks description.
> ---
>  .../devicetree/bindings/nvmem/mxs-ocotp.txt        | 24 -----------
>  .../devicetree/bindings/nvmem/mxs-ocotp.yaml       | 50 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
> 

Applied, thanks!
