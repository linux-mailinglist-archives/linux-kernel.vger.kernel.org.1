Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08D29929B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786160AbgJZQhp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Oct 2020 12:37:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:7429 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786153AbgJZQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:37:45 -0400
IronPort-SDR: 2BUutrjpUZYrjtIqXN7m8pYfh5no8ZiKTmYJg8zF0QN0X9prirwFnruDyjVwvKCaSCPH6QVUkh
 vzO43wPSr47Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="229584923"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="229584923"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 09:37:42 -0700
IronPort-SDR: YEOvthm1SG3Pc3p9RQCPYcX74GCP4R2l9yoqfGpTbKYoNbx2Po7VcReuHg5YmmDPaQAc99QEIe
 1OapCFGUFlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="355241555"
Received: from irsmsx606.ger.corp.intel.com ([163.33.146.139])
  by fmsmga002.fm.intel.com with ESMTP; 26 Oct 2020 09:37:40 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX606.ger.corp.intel.com (163.33.146.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Oct 2020 16:37:39 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 26 Oct 2020 16:37:39 +0000
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Jiri Kosina" <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] seq_buf: avoid type mismatch for seq_buf_init
Thread-Topic: [PATCH] seq_buf: avoid type mismatch for seq_buf_init
Thread-Index: AQHWq7KliO24+notLUCpY3Gs9snQi6mqFBIg
Date:   Mon, 26 Oct 2020 16:37:39 +0000
Message-ID: <0fb5bff4b99c40e5956b8af34d5c1483@intel.com>
References: <20201026161108.3707783-1-arnd@kernel.org>
In-Reply-To: <20201026161108.3707783-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 5:10 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=2 prints a number of warnings for one function that
> has a pointer type mismatch:
> 
> linux/seq_buf.h: In function 'seq_buf_init':
> linux/seq_buf.h:35:12: warning: pointer targets in assignment from 'unsigned char *' to 'char *' differ in signedness [-Wpointer-sign]
> 
> Change the type in the function prototype according to the type in
> the structure.
> 
> Fixes: 9a7777935c34 ("tracing: Convert seq_buf fields to be like seq_file fields")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks,
Czarek

