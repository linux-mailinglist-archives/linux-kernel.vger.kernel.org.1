Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6A27238E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIUMRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIUMRD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:17:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6FC620EDD;
        Mon, 21 Sep 2020 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600690622;
        bh=/a5r1ovv+an3wxEPmLoK/lTCGHZSrG3P20ba8ouoTbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XX5fDJ7p2bLyecXTfJly36yppqZobhShw9icGCpjPwedZnU8jvujb5eemgWaY0ywo
         vc+OYQUYBmOqL+P3cCDCBIbNeSdr8I+7UpZqQpk6r71z0mFjHxiyx2oB1P0I5v6FQ7
         BC24Cz3C6gIA0wdCH495DTSoecf0d+/5s3umAEjk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 15BAB400E9; Mon, 21 Sep 2020 09:17:00 -0300 (-03)
Date:   Mon, 21 Sep 2020 09:17:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 7/7] perf diff: Support hot streams comparison
Message-ID: <20200921121700.GH1996959@kernel.org>
References: <20200911080353.13359-1-yao.jin@linux.intel.com>
 <20200911080353.13359-8-yao.jin@linux.intel.com>
 <20200917202608.GF1431236@kernel.org>
 <a0eabcde-d498-2ec5-af4f-998380951782@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0eabcde-d498-2ec5-af4f-998380951782@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 19, 2020 at 12:41:35PM +0800, Jin, Yao escreveu:
> Hi Arnaldo,
> 
> On 9/18/2020 4:26 AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Sep 11, 2020 at 04:03:53PM +0800, Jin Yao escreveu:
> > > This patch enables perf-diff with "--stream" option.
> > > 
> > > "--stream": Enable hot streams comparison
> > > 
> > > Now let's see examples.
> > > 
> > > perf record -b ...      Generate perf.data.old with branch data
> > > perf record -b ...      Generate perf.data with branch data
> > > perf diff --stream
> > > 
> > > [ Matched hot streams ]
> > > 
> > > hot chain pair 1:
> > >              cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
> > >          ---------------------------              --------------------------
> > >                        main div.c:39                           main div.c:39
> > >                        main div.c:44                           main div.c:44
> > > 
> > > hot chain pair 2:
> > >             cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
> > >          ---------------------------              --------------------------
> > >            __random_r random_r.c:360               __random_r random_r.c:360
> > 
> > Would it be interesting to get the associated source code and show right below
> > these file:number lines?
> > 
> > - Arnaldo
> > 
> 
> I'm thinking we can implement this function in callchain_list__sym_name(),
> and then all callchain functionality will benefit from it. While that looks
> to be another patchset. :)

Sure, after we go thru the process of merging the current one.
 
> Thanks
> Jin Yao

-- 

- Arnaldo
