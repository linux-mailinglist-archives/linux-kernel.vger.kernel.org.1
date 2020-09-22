Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411D27422F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIVMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:38:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:23179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgIVMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:38:58 -0400
IronPort-SDR: Q0YM6ACecPBlhEKSf39OQlltbjcSvOJD6EwIe7GsWpgTIXgbP/D4b69+kGEwJ+j27llTkcUbV0
 3Rs25jy6udsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="159881992"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="159881992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 05:38:58 -0700
IronPort-SDR: rrbJlf5lCJDP9JLWjISeP/CIPDPlFa64KzngGbvNVuaxl2S6kCNzwwWwx7cc8Ggh0k4koPTqKE
 cKzZjrcbUC7w==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="454479654"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 05:38:55 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 22 Sep 2020 15:38:52 +0300
Date:   Tue, 22 Sep 2020 15:38:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: use kobj_to_dev()
Message-ID: <20200922123852.GZ2495@lahna.fi.intel.com>
References: <1600777096-25725-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600777096-25725-1-git-send-email-wangqing@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:18:13PM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks but I have already queued a similar patch from Tian Tao:

  https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/commit/?h=next&id=fff15f23b8e74c2f969a5d25f29d0565e76e7137
