Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29412F1832
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbhAKOZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:25:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:18178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbhAKOZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:25:25 -0500
IronPort-SDR: It/1ov5tVny01R8jrU9W1PRXnRPrqnp5+LcNXMYR3c/DG1jjRQz9SB9uDFc7Th1mFgBKMrGHnS
 HRQmFJUfK03Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="262649132"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="262649132"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 06:23:32 -0800
IronPort-SDR: jGjkKTdMePE//8GrdJ1upWPqyQQfN0ZpzLLdBFE0GN0sC7MFNUJ4/+bm7LdebiXk8o9ahj3Ffl
 Gj/+UXZTPlvg==
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="381025606"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 06:23:29 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Jan 2021 16:23:26 +0200
Date:   Mon, 11 Jan 2021 16:23:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Constify static attribute_group structs
Message-ID: <20210111142326.GM968855@lahna.fi.intel.com>
References: <20210108230918.32302-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108230918.32302-1-rikard.falkeborn@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 12:09:19AM +0100, Rikard Falkeborn wrote:
> The only usage of these is to put their addresses in arrays of pointers
> to const attribute_groups. Make them const to allow the compiler to put
> them in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Applied to thunderbolt.git/next, thanks!
