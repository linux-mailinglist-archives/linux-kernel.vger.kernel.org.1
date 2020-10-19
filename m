Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE4292F61
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbgJSU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:26:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38195 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:26:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id h10so1432165oie.5;
        Mon, 19 Oct 2020 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XfquN+jLUKwzjwaiCkY1B6coFTTURkYacPYZ2F52YKA=;
        b=c2ZKZF0pfsosDL26fkqJ5PgHvY4zCBjbueEfTrS5B6wSxhhpIdctPWmi1g5EptYONv
         pYaslPLPnGiUYpg79FsbIbOlCpShzub+IB6G6TSJhiUuHrmvTrXQJWgEa+eyR9l06s8t
         3zSDV3S9XJEzXg4ehMcqBiVnaGERDF/5w3RqXf8AkzP7YL7UmVVu02REyGBBYLVgm3xe
         LTeALIRnvrOLsGCTGT2iPiSbHjMjVgC82fVcoGih505v3bwppbilcKDVd1dpk/+NwJnT
         4iTu5s5Bj3r89+BgQz2qf4R6CF99dbAZ9pwByXPwy/b8kc6UDvVobXcZbKeaYUAbGDS4
         yYEw==
X-Gm-Message-State: AOAM530RqclAaqp4xrWgI1u1qAs/c4YVBoffCTSfsgaKuvr99HxA4heY
        qJT0NID8KdSbsyDFFWIYQ/oDbpdf4g==
X-Google-Smtp-Source: ABdhPJzsabpxr5YCChl9ztj7eUGnP0Wg+3h4WNy0xEkTLZ7GCfUfGe6W3x2YrnBSXyPoNWUahK5Mgg==
X-Received: by 2002:aca:5a84:: with SMTP id o126mr819009oib.100.1603139215932;
        Mon, 19 Oct 2020 13:26:55 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d27sm202565otc.6.2020.10.19.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:26:55 -0700 (PDT)
Received: (nullmailer pid 3549356 invoked by uid 1000);
        Mon, 19 Oct 2020 20:26:54 -0000
Date:   Mon, 19 Oct 2020 15:26:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: stm32_rproc: update for
 firmware synchronization
Message-ID: <20201019202654.GA3549318@bogus>
References: <20201014125441.2457-1-arnaud.pouliquen@st.com>
 <20201014125441.2457-3-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014125441.2457-3-arnaud.pouliquen@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 14:54:39 +0200, Arnaud Pouliquen wrote:
> Add new properties description used to attach to a pre-loaded
> firmware according to the commit 9276536f455b3
> ("remoteproc: stm32: Parse syscon that will manage M4 synchronisation")
> which updates the driver part.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
