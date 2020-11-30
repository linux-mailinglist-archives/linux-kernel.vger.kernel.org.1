Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407BC2C7D29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgK3DKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:10:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:15684 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgK3DKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:10:16 -0500
IronPort-SDR: AzEY6v4+ISaMA4o15aA7H/1PuZVxqIReFoByMtxTVC2h2W7+FlnNnZpqp5TfM3nbkvgrZFZD/j
 H10cC2lrCDWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="160346974"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="160346974"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:08:35 -0800
IronPort-SDR: 5AcvkbbkvEdLh4qRxE1Jn1UFWC0eqLHkMMq33U5xWb/bHELItUBHh4u2adm6K+P0QRlp5SOAds
 uRa0lt2IyiXw==
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="364032481"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:08:35 -0800
Date:   Sun, 29 Nov 2020 19:08:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <20201130030828.GA1363814@tassilo.jf.intel.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126063029.2030-1-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 01:30:26AM -0500, Paul Gortmaker wrote:
> But you currently can't make use of clear_warn_once unless you've got
> debugfs enabled and mounted - which may not be desired by some people
> in some deployment situations.

Seems awfully special purpose. The problem with debugfs is security,
or is it no convenient process that could do cron like functionality? 

If it's the first, perhaps what they really need is a way to get
a partial debugfs? 

-Andi
