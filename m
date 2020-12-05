Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105562CF895
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgLEBYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLEBYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:24:51 -0500
Subject: Re: [PATCH v7] f2fs: compress: support compress level
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607131451;
        bh=93gxGwOSBgRtHO3BuuzrRBtxRaKxnLT1haGacM/gHN4=;
        h=To:Cc:References:From:Date:In-Reply-To:From;
        b=peZvBJ61wuh4l3iXG2xtjPW/Ncr8OWr/9FXEu5Cuxk+u19McMXOPa3HeYcFM3jwMT
         sdu4q3okXvpK5A8b66g8tU4cdG/pzOKcRCVviZt3hNUXyr4cqwe5l0IEM15QQN4gmg
         ENzo6G2MEjoe/h6sq+s9tp2s3rNEHvCuZvFRbzUqZMv4luyPWhNsH9u8814ePLZR+6
         OWLALD4+GsdI4c//+qNRynNxIB6rN/gQCHBQucpEBvWZFKzYPvxdEF0Qfh+v0g0r/A
         UHdemDT1qBGodqE8+f/wzpmnwpRXA7qZAb4d1F0+BUv6mZCeyKa714ursHdzAglqaI
         /Ee00InKwl82g==
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20201204102423.114091-1-yuchao0@huawei.com>
 <X8qJBdQZmZ2SyN9m@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <7be5abe7-af85-4941-edc6-7e9b592a5dca@kernel.org>
Date:   Sat, 5 Dec 2020 09:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <X8qJBdQZmZ2SyN9m@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/5 3:07, Jaegeuk Kim wrote:
> 
> I removed wrong spaces here and merged in dev-test till getting reviewed.

Sorry, I sent the wrong version which is based v5 + fixes... :(

Thanks,
