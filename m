Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057551BDD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgD2NJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 09:09:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33156 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2NJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:09:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id s10so2482962wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bH0bbqVQbeUY5It5xqT1zYzIFKuvRYaWvNIr4hXMeAE=;
        b=A6nT6ZBosg6K9CwrMGA5GRmhDnyzkjMyh1nnsJQlk5h0AOrSQLdnedvujwkJJc/WxC
         zkAFapclZQ5wCCWOsr3fW7YPqFqxRuZgY1iIqnsta332+xrYNNn4tgD8RyR9PxzQG5na
         3BDbJfOazXjIhvirlXHA9FmL0hETLwPj89/waoyZK7uhX1WnyM9ydyn8KkgOA34LyH/X
         9S5RLoJsryzUn0/z7RzIrU2TBvYJBEBhsAxSL2dJseBOH4R2Vsbek8aSLy5lBDFsev5P
         MWc1MaUqjMbWvy1ApHCQWzXHJA/U37UuVp7Zkx0j6ZBkDP+z+btl4wlrgE3KgFUTX3Ug
         fmvg==
X-Gm-Message-State: AGi0PubIpPtkBSSOWFLp2cr2vftJ9AqrsLfVmJ0Fqg9rsf5GQLHAQjD0
        dfqpW7wxaPsOLmIe8QCDn1M=
X-Google-Smtp-Source: APiQypJkDxrRS6EsgUtBFz8WMEi0Jgs+THobIMxefSCsUFprNNyWNSEjL+uraVhlwtSj/oRYvvDRIQ==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr38561028wrr.354.1588165755294;
        Wed, 29 Apr 2020 06:09:15 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id n2sm30894945wrq.74.2020.04.29.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:09:14 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:09:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 1/1] mm/vmscan.c: change prototype for shrink_page_list
Message-ID: <20200429130912.GE28637@dhcp22.suse.cz>
References: <20200429120951.GC28637@dhcp22.suse.cz>
 <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
 <CGME20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c@epcms5p6>
 <20200429125323epcms5p67a539511c573cd598d78b726503e3204@epcms5p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429125323epcms5p67a539511c573cd598d78b726503e3204@epcms5p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 18:23:23, Maninder Singh wrote:
> 
> Hi,
> 
> >
> >Acked-by: Michal Hocko <mhocko@suse.com>
> >
> >Is there any reason to move declarations here?
> >
> 
> "unsigned int ret" was changed mistakenely, sending V2.
> and "unsigned int nr_reclaimed" is changed to remove hole.

Could you be more specific? Have you seen a better stack allocation
footprint?

-- 
Michal Hocko
SUSE Labs
