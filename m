Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460602109AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgGAKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 06:51:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:4288 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbgGAKvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:51:01 -0400
IronPort-SDR: i1r71mXlTJGdL9T6fPgcGdNmgcpoWFaiovfbVayR8sx6yhNLH5nZDvBjPkXKgIrrMXOZw8cG9Q
 iSVWDdrx0iGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="211589913"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="211589913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:50:59 -0700
IronPort-SDR: fqdJjYt0cdpBdhV9T+5fkkEjx1fpdbgRU0STGFzgfVj1c3WKqbZkEadWiXoQVuy7trbiZuO4AU
 HF4yU22+wEsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="386975562"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2020 03:50:56 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 01 Jul 2020 13:50:55 +0300
Date:   Wed, 1 Jul 2020 13:50:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thunderbolt: ensure left shift of 512 does not
 overflow a 32 bit int
Message-ID: <20200701105055.GQ5180@lahna.fi.intel.com>
References: <20200630145558.516961-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630145558.516961-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:55:58PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 32 bit int value 512 is being left shifted and then used in a context
> that expects the expression to be a larger unsigned long. There may be
> a potential integer overflow, so make 512 a UL before shift to avoid
> any such issues.
> 
> Addresses-Coverity: ("Uninintentional integer overflow")
> Fixes: 3b1d8d577ca8 ("thunderbolt: Implement USB3 bandwidth negotiation routines")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!
