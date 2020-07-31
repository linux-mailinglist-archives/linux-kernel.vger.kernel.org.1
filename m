Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BD23494B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgGaQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:41:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60988 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgGaQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:41:05 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42CA620B4908;
        Fri, 31 Jul 2020 09:41:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42CA620B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596213665;
        bh=QiCtwckG2vlecyqkJ9uggElJgAkUp42WolJ2XV4u8BI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kzu4uiijNX3VibaBuV7Oa5kLr4cqBTreqcq3OdXtgZj7WM/Ousq81OnIpX7VWDz+s
         MksQMyTPBqG1ukv4NzJsA30GIZJis8xlfl43fHvsC+vQaC39gXVKu5bwQ1K3PYrPO6
         HWYVO5U64RQ0OAbvtqZgyh4yd6hnL0XM1M0XP6BA=
Date:   Fri, 31 Jul 2020 16:41:05 +0000
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
Message-ID: <20200731164105.d2emgswenqc6hqyp@viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/26 06:49AM, Vineeth Pillai wrote:
> 
> 
> Sixth iteration of the Core-Scheduling feature.
>
I am no longer with DigitalOcean. Kindly use this email address for all
future responses.

Thanks,
Vineeth
