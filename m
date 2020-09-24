Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69CE27777F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgIXRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:08:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:59390 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbgIXRIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:08:37 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C6D4E2CB;
        Thu, 24 Sep 2020 17:08:35 +0000 (UTC)
Date:   Thu, 24 Sep 2020 11:08:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v3 2/2] docs: trace: ring-buffer-design.rst: use the new
 SPDX tag
Message-ID: <20200924110833.2c669418@lwn.net>
In-Reply-To: <20200918131917.13d9f570@gandalf.local.home>
References: <cover.1599628249.git.mchehab+huawei@kernel.org>
        <dbc9bd9ab30c6862e465343239e82102cbdc0f39.1599628249.git.mchehab+huawei@kernel.org>
        <20200918131917.13d9f570@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 13:19:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  9 Sep 2020 07:14:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > SPDX v3.10 gained support for GFDL-1.2 with no invariant sections:
> > 
> > 	https://spdx.org/licenses/GFDL-1.2-no-invariants-only.html
> > 
> > Let's use it, instead of keeping a license text for this file.  
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

OK, I've applied this; it looks like Greg already got part 1.

Thanks,

jon
