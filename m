Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96E2FE886
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbhAULQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:16:44 -0500
Received: from foss.arm.com ([217.140.110.172]:60068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbhAULOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:14:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B00411B3;
        Thu, 21 Jan 2021 03:13:19 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.35.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6049D3F719;
        Thu, 21 Jan 2021 03:13:18 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:13:15 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121111315.GB48431@C02TD0UTHF1T.local>
References: <20210121072031.23777-1-w@1wt.eu>
 <jhjzh1235yr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjzh1235yr.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:05:48AM +0000, Valentin Schneider wrote:
> Thanks for having a look at this! And kuddos to Mark for nudging the
> right people.

Likewise to Paul for poking Willy!

Thanks all,
Mark.
