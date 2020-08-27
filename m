Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC93254EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH0Tfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 15:35:47 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38828 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Tfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:35:45 -0400
Received: by mail-ej1-f66.google.com with SMTP id oz20so9247377ejb.5;
        Thu, 27 Aug 2020 12:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qnywG+k8I2kCIcWT+/GLTPy2owfZtBQFEtrvVg+qN7Y=;
        b=KtZbFHyLtlICFYtMs26mUSu8E8OmSyXeBjy+eDAdYk7CsF/QzfoWiCC/2xAUauUVGq
         aSZvmvi+gcb1wa5/EYaV8f2OCfmBuQmCqciqyp4+TCeNOC7JmGEPEmxJF4Vb4ZqOzXL2
         ZJ7gyP6qHTi3DhpEgD8PWbVOO2V0swVmJt8oB41A7BEx5tFHFyzGO4PJXxzZkxQzNb2P
         cLjgwr3IbD6v6IbZvAM6ilU+ykBpGJm1/sSLBVaVBbMrO80hM4AD49WKXQjqbjfvgeL9
         DfgEpPI8dHeUk1AwkaIyyZoc4ETRRYM6BdcEDfF9YI3CnfyR+HVHMttBC6HuBOhk2upu
         kHXw==
X-Gm-Message-State: AOAM532L4gwaI6JSNQO59TB60Rx5xpKT08Zs2b8NugVmn/mHCCJzZ04t
        BAN8lMkTCxEyzzXULdKuIKo=
X-Google-Smtp-Source: ABdhPJxr2URPYCfPDlIaH3QGdBvjIj2gvpstQH4hgeFZk/KkZJArDUbpg51QiT2pzPdwVQ/CCNywrA==
X-Received: by 2002:a17:906:36c2:: with SMTP id b2mr21723926ejc.238.1598556942948;
        Thu, 27 Aug 2020 12:35:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id hh9sm2593987ejb.113.2020.08.27.12.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 12:35:42 -0700 (PDT)
Date:   Thu, 27 Aug 2020 21:35:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     santosh.shilimkar@oracle.com
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: emif: Remove bogus debugfs error handling
Message-ID: <20200827193540.GA8837@kozik-lap>
References: <20200826113759.GF393664@mwanda>
 <10387fe0-579a-de71-44ad-ac585ff604d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10387fe0-579a-de71-44ad-ac585ff604d6@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:52:37AM -0700, santosh.shilimkar@oracle.com wrote:
> On 8/26/20 4:37 AM, Dan Carpenter wrote:
> > Callers are generally not supposed to check the return values from
> > debugfs functions.  Debugfs functions never return NULL so this error
> > handling will never trigger.  (Historically debugfs functions used to
> > return a mix of NULL and error pointers but it was eventually deemed too
> > complicated for something which wasn't intended to be used in normal
> > situations).
> > 
> > Delete all the error handling.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> Looks good to me !!
> 
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Thanks, applied.

Santosh,
Your email does not match one in ack.  I understand this is just a
mistake so I put the ack.  However the tool (b4-am) ignores such cases
so ack could be lost in the future.

Best regards,
Krzysztof

