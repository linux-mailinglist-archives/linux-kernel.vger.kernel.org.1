Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2270726057F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgIGUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 16:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:19:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 989A9AB54;
        Mon,  7 Sep 2020 20:19:44 +0000 (UTC)
Date:   Mon, 7 Sep 2020 13:03:22 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     jason.wessel@windriver.com, dianders@chromium.org, oleg@redhat.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] kdb: Use newer api for tasklist scanning
Message-ID: <20200907200322.shuexcour6kmegq6@linux-p48b>
References: <20200831193435.22141-1-dave@stgolabs.net>
 <20200907134614.guc4tzj3knnihbe4@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200907134614.guc4tzj3knnihbe4@holly.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Sep 2020, Daniel Thompson wrote:

>No objections to the change but kdb doesn't use tsk->thread_group,
>it uses do_each_thread/while_each_thread. Can we change this to
>say that is osbsolete and racy to use while_each_thread() (that's
>pretty much what the description of the patch that introduced
>for_each_thread said)?

Well while_each_thread() is just a loop around next_thread(),
which uses tsk->thread_group. But sure, I can rephrase a v2 to say
while_each_thread.

>
>Additionally the debug_core uses do_each_thread/while_each_thread.
>Presumably that would like to be changed as well?

Are you referring to gdb_cmd_query()? Yeah, that's another one that
can be replaced. Because we need not worry about races, it's rather
simple to justify both replacements in the same patch, which I'll
add to v2.

Thanks,
Davidlohr
