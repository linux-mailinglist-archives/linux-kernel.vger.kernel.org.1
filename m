Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504FA227261
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 00:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGTW1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 18:27:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:35655 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgGTW1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:27:02 -0400
IronPort-SDR: ceJphl1nA3NL/xKjiSTSt6twpDYPI2W4s8KSTOxK7EDGuS2m2y9IxzzbA5okWfuHTZF/rooFyc
 +YbGFLY/lYoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214687720"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="214687720"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:27:01 -0700
IronPort-SDR: HPf5WW18qxVh8D1vVD5lPRDwS3d/DcWXdcI9DJ2eQMz70CHw0Qq2HEPRgs91kKXXVFb1+IGKaE
 lxOdfvmizNxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="431774516"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2020 15:27:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B69AB301BF5; Mon, 20 Jul 2020 15:27:01 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:27:01 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 10/12] perf auxtrace: Add itrace 'q' option for
 quicker, less detailed decoding
Message-ID: <20200720222701.GD1180481@tassilo.jf.intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
 <20200710151104.15137-11-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710151104.15137-11-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +"				q:			quicker (less detailed) decoding\n" \

Perhaps add '(can be repeated)'

-Andi
