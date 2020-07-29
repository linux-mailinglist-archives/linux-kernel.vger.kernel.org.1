Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15541232208
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgG2P4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 11:56:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40614 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2P4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:56:52 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B267972CCDC;
        Wed, 29 Jul 2020 18:56:49 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7EABE4A5036;
        Wed, 29 Jul 2020 18:56:47 +0300 (MSK)
Date:   Wed, 29 Jul 2020 18:56:47 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Should perf version match kernel version?
Message-ID: <20200729155647.xte33krus3mak3wu@altlinux.org>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that most distros try to have perf version to match with
running kernel version. Is is requirement? Would it be better to have
single perf from kernel mainline to work with any (older) kernel
version?

We have different kernel versions in ALT Linux (stable for 4.19, 5.4,
and 5.7) and I want to understand if we should have three perfs or
single package will be enough.

Thanks,

