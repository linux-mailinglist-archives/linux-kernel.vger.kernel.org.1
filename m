Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4191B04BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDTIo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:44:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:44:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48CE1AB89;
        Mon, 20 Apr 2020 08:44:54 +0000 (UTC)
Message-ID: <1587372294.26844.24.camel@suse.cz>
Subject: Re: [Bisected] Oops witn 5.7.0-rc1
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Apr 2020 10:44:54 +0200
In-Reply-To: <41ae3b90-8e14-9db5-a804-5fdb2eebac03@skogtun.org>
References: <41ae3b90-8e14-9db5-a804-5fdb2eebac03@skogtun.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-18 at 18:15 +0200, Harald Arnesen wrote:
> Kernel 5.7.0-rc1 and later won't boot on my ThinkPad T510i.
> 
> The attached jpeg is all I can capture of the oops. Bisected to commit
> 1567c3e3467cddeb019a7b53ec632f834b6a9239, but I cannot revert that to check.
> 
> A strange thing: The same commit is in 5.6.5, and that kernel boots
> fine. 5.7.0-rc1 also boots fine on my desktop.
> 
> Screenshot and config attached. Please request any further info.

Hello Harald,

thanks for the report.

The problem you encountered is likely due to a bug where the code doesn't work
on machines with less than 4 physical CPU cores. It is fixed by this patch
series:

https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz/

The series has been acknowledged by the subsystem maintainers but not yet
merged in any tree (it is expected to land in the "tip" tree and then be pulled
by Linus).


Thanks,
Giovanni Gherdovich
