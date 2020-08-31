Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58BA2583F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 00:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHaWQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 18:16:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:39036 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHaWQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:16:31 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B372C537;
        Mon, 31 Aug 2020 22:16:30 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:16:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-ia64@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs/ia64: Drop obsolete Xen documentation
Message-ID: <20200831161629.2dc218ff@lwn.net>
In-Reply-To: <20200827175405.24344-1-andrew.cooper3@citrix.com>
References: <20200827175405.24344-1-andrew.cooper3@citrix.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 18:54:05 +0100
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> While the xensource.com URLs referenced still exist, neither the Xen or Linux
> 2.6.18 fork have been touched since 2009, 11 years ago.  Other URLs are dead.
> 
> IA64 support was removed in Xen 4.2, in 2012.  Relegate this piece of
> documentation to source history.
> 
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>

Applied, thanks.

jon
