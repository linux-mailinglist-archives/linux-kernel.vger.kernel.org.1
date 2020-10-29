Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1D829ECF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgJ2NcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:32:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgJ2NcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:32:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63FCDAF2C;
        Thu, 29 Oct 2020 13:32:06 +0000 (UTC)
Date:   Thu, 29 Oct 2020 14:32:05 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: False positive from checkscript: git git://...
Message-ID: <20201029143205.197ff58f@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, Joe,

I have hit this false positive from checkscript:

WARNING: Possible repeated word: 'git'
#20: FILE: MAINTAINERS:5289:
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-next

Obviously that's going to happen a lot as this is actually the proper
way to list a git tree in that file. Could you please add an exception
for that case?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
