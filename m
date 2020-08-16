Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589D5245896
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgHPQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 12:37:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:39833 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgHPQhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 12:37:22 -0400
IronPort-SDR: xUlgCDdBHjk3LZtCP/c+eIgOgg51rwAh91EVV/UMHoE16DceQSnEFyfPEHoSC3B7QM3GkOVoN+
 iJQJdmYO76aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="172649512"
X-IronPort-AV: E=Sophos;i="5.76,321,1592895600"; 
   d="scan'208";a="172649512"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 09:37:21 -0700
IronPort-SDR: JcU+Vw3unFudUkfQBfxRi0UJLyHutaheNeeeEkbdGjNqrfmnE9ajNKyG8pYghBtui63z/CHaKi
 OEtLFn8U88WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,321,1592895600"; 
   d="scan'208";a="326194330"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2020 09:37:21 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AD204301C4D; Sun, 16 Aug 2020 09:35:21 -0700 (PDT)
Date:   Sun, 16 Aug 2020 09:35:21 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
Subject: Re: [PATCH v5 1/3] perf jevents: Add support for parsing
 perchip/percore events
Message-ID: <20200816163521.GF1486171@tassilo.jf.intel.com>
References: <20200816090719.72018-1-kjain@linux.ibm.com>
 <20200816090719.72018-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816090719.72018-2-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -321,7 +331,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>  static int print_events_table_entry(void *data, char *name, char *event,
>  				    char *desc, char *long_desc,
>  				    char *pmu, char *unit, char *perpkg,
> -				    char *metric_expr,
> +				    char *metric_expr, char *aggr_mode,
>  				    char *metric_name, char *metric_group,
>  				    char *deprecated, char *metric_constraint)

We should really define a struct now to pass the parameters,
the callback prototype is getting ridiculous.

I know it's my fault originally, but sorry you probably have to do it
because you are touching it last.

-Andi
