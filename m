Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B81B832F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 04:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDYCKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 22:10:53 -0400
Received: from gentwo.org ([3.19.106.255]:35186 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgDYCKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:10:52 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 541B73F57C; Sat, 25 Apr 2020 02:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 530603E8A0;
        Sat, 25 Apr 2020 02:10:52 +0000 (UTC)
Date:   Sat, 25 Apr 2020 02:10:52 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
In-Reply-To: <20200423210147.GA83398@carbon.DHCP.thefacebook.com>
Message-ID: <alpine.DEB.2.21.2004250210280.7624@www.lameter.com>
References: <20200422204708.2176080-1-guro@fb.com> <20200422204708.2176080-5-guro@fb.com> <alpine.DEB.2.21.2004222349280.20021@www.lameter.com> <20200423210147.GA83398@carbon.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Roman Gushchin wrote:

> Something like this?

Yup.
