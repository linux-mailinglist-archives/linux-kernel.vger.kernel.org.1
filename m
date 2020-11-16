Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF212B53BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgKPVYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:24:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:19304 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgKPVYP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:24:15 -0500
IronPort-SDR: O5SyfBmxgWx2IEJ1VMOjrrweaWuvDI48ahts9lJ/3YK9Gmz0vbxud9MJcbQRa11mpTPSKrd5jJ
 tjzYmCtVAN3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="150668264"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="150668264"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 13:24:09 -0800
IronPort-SDR: Zd++RwuYH781hr1Xc8jf9LnQIUAy6LV7DNkhA0QyuC5f5S+OZhqMYuZgbTJU5CSWakpZTmRmn+
 Y/G7Hu2sLA9Q==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="475673801"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 13:24:06 -0800
Date:   Mon, 16 Nov 2020 13:24:04 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
Message-ID: <20201116212404.GX894261@tassilo.jf.intel.com>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
 <20201116170553.GG509215@kernel.org>
 <CAP-5=fXJCqB6sN+f-eRSwc+Za3Yri+QWMpg_G7xfz=i-cTBH3A@mail.gmail.com>
 <20201116192440.GC614220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116192440.GC614220@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You mean change event-converter-for-linux-perf to add this as JSON
> comments at the start of the generated files?

JSON doesn't support comments unfortunately
(unless they're somehow part of the data schema)

-Andi
