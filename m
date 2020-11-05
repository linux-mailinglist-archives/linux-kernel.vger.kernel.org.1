Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305B52A7945
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgKEI3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgKEI3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:29:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0E6D20729;
        Thu,  5 Nov 2020 08:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604564953;
        bh=Jr9tsp8+ZrZH7CCn7mpR4MqQWi79j5bU/c2gDmyus4o=;
        h=Date:From:To:Cc:Subject:From;
        b=TWlRUtI/zYmihI7NQ34EdmEPqEVD/HcSVYsRIDfGx024hZ8wbwnLenpOyYvhprB0u
         qA/5oHndsH4+cyd/BSNx/ZmMEkBec63Xnx0Sk+3ukXnQgJMAcL2WiW13mEhoIRtMTR
         9zhgMpiz2f98D3izwGSVsmRouJAjQBQuXxJ4ioUs=
Date:   Thu, 5 Nov 2020 09:30:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     tech-board-discuss@lists.linuxfoundation.org
Subject: Linux Kernel Code of Conduct Committee: October 2020 report
Message-ID: <20201105083002.GA3429143@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite our previously hoped-for timely release of these reports that
were mentioned last time:
	https://lore.kernel.org/lkml/20200103105614.GC1047442@kroah.com/
that hasn't happened, so here's the report for the first 10 months of
2020.  I will work to do better on this in the future, my apologies.

Linux Kernel Code of Conduct Committee: October 2020

In the period of January 1, 2020 through October 31, 2020 the Committee
received the following reports:
  - Unacceptable behavior or comments in email: 1
  - Unacceptable comments in github repo by non-community members: 1
  - Unacceptable comments toward a company: 1

The result of the investigation:
  - Education and coaching: 1
  - Locking of github repo for any comments: 1
  - Clarification that the Code of Conduct covers conduct related to
    individual developers only: 1

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to uphold
the professional standards of our community.  If you have questions
about this report, please write to <conduct@kernel.org>.

------------

The website at https://www.kernel.org/code-of-conduct.html has a list of
this, and other past Code Of Conduct Committee reports.

thanks,

greg k-h
