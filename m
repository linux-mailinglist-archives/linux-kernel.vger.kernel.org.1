Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01E1C290C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 01:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEBXyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 19:54:10 -0400
Received: from gentwo.org ([3.19.106.255]:33454 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgEBXyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:54:10 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 58CB63EBBD; Sat,  2 May 2020 23:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 56CF83EBB9;
        Sat,  2 May 2020 23:54:09 +0000 (UTC)
Date:   Sat, 2 May 2020 23:54:09 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
References: <20200422204708.2176080-1-guro@fb.com> <20200422204708.2176080-5-guro@fb.com> <alpine.DEB.2.21.2004222349280.20021@www.lameter.com> <20200423000530.GA63356@carbon.lan> <alpine.DEB.2.21.2004250208500.7624@www.lameter.com> <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com> <20200427164638.GC114719@carbon.DHCP.thefacebook.com> <alpine.DEB.2.21.2004301625490.1693@www.lameter.com> <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Roman Gushchin wrote:

> Sorry, but what exactly do you mean?

I think the right approach is to add a pointer to each slab object for
memcg support.

