Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82F21CE2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEKSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:46:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54212 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgEKSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:46:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 251DD2A13E8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        song@kernel.org, breeves@redhat.com, mpatocka@redhat.com,
        khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v4 0/2] Historical Service Time Path Selector
Organization: Collabora
References: <20200511163910.3778467-1-krisman@collabora.com>
        <20200511170235.GA7719@redhat.com> <85ftc6l7lb.fsf@collabora.com>
        <20200511173155.GA7892@redhat.com> <20200511184143.GA8274@redhat.com>
Date:   Mon, 11 May 2020 14:46:21 -0400
In-Reply-To: <20200511184143.GA8274@redhat.com> (Mike Snitzer's message of
        "Mon, 11 May 2020 14:41:43 -0400")
Message-ID: <85blmul37m.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer <snitzer@redhat.com> writes:

> OK, that concall's issue had nothing to do with needing higher
> resolution time (was about IOPs realized with requested-based vs
> bio-based).
>
> Reality is, DM won't need anything higher resolution than jiffies until
> block core's interfaces require something other than jiffies
> (e.g. generic_end_io_acct).
>
> So feel free to proceed with the conditional time fetch solution you
> were going to run with (prior to my previous mail asking you to hold
> off).
>
> Sorry for the noise.  Thanks,
> Mike

No problem, thanks for the information.  I get started on it.


-- 
Gabriel Krisman Bertazi
