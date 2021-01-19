Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A5E2FBB43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbhASPdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390978AbhASPc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:32:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9252311C;
        Tue, 19 Jan 2021 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611070307;
        bh=l3M3/zW0/wzWUGsnP51r3MHVTfcnQ/4aIAliL+iZOFo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qX5D0W4VTFyPiozoQC94PuCkWEDHoDeytp9HhloWdffizOCISO+jI2Pek7nhbNgqn
         mC320wsUG1ULKiC2s+MDdfctwtkYctRHIRE7feZ5zYu8elsaXtw3dxr0a4MEY5QMiy
         ma+IG8VZvxA+hkSSIeoyY2/1TGnnYMbi5BpDtp+/lBAcY8NjgAByd3T8rZPzmhm4c5
         GMxVoXUXkAtcoYYORL+3yZexayKurIlMnOBHyo/gtZDQHXQoSd0TZvAv0xG/TGzx7Z
         tUZ6vxtiXjJq+3dc4wYwlt/A5MuWFj/ftv1Yt7WO8AHt1NV0fFCZwYkKO+QYOAhQJv
         2Gx52pHVxrbqQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 29B3A35226D5; Tue, 19 Jan 2021 07:31:47 -0800 (PST)
Date:   Tue, 19 Jan 2021 07:31:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        mark.rutland@arm.com
Subject: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210119153147.GA5083@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Willy,

Some people are having trouble running rcutorture on ARMv8.  They
get things like this from the nolibc build of initrd:

https://paste.debian.net/1181762/

The nolibc.h file says this:

/* Some archs (at least aarch64) don't expose the regular syscalls anymore by
 * default, either because they have an "_at" replacement, or because there are
 * more modern alternatives. For now we'd rather still use them.
 */

Are these build failures expected behavior on ARMv8?

							Thanx, Paul
