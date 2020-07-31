Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2A234B69
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgGaTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 15:03:01 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42297 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726925AbgGaTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:03:01 -0400
Received: (qmail 47503 invoked by uid 1000); 31 Jul 2020 15:03:00 -0400
Date:   Fri, 31 Jul 2020 15:03:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
Message-ID: <20200731190300.GA47100@rowland.harvard.edu>
References: <2672940.cHDmkauF2A@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2672940.cHDmkauF2A@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add kerneldoc comments to multiple PM-runtime helper functions
> defined as static inline wrappers around lower-level routines to
> provide quick reference decumentation of their behavior.
> 
> Some of them are similar to each other with subtle differences only
> and the behavior of some of them may appear as counter-intuitive, so
> clarify all that to avoid confusion.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
