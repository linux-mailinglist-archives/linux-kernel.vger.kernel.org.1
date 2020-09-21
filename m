Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA5273572
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgIUWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:06:43 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:58736 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:06:43 -0400
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6536713C2B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:06:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6536713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600726002;
        bh=Of1v452+3HXRU2qeRfHiuZTa4Vr+m0jYCSgR5HWBZ9g=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=VKtlUyfK4ahgUAt6ma744M0zkZwkDqyn/2E1ikAA2nVt2yflvMcNcRrdNF3CS77mB
         taJsLQgFiNjPcH/2Rb+sI1cPtR+5toThQHKO4GD+hrpkYLB/tJ8co2Lywnin4TuioP
         +otGB+JHyz0/DqVeUlkbflqYUd1zxA3E0mVVN8c0=
Subject: Re: Build failure for today's tree, Fedora-32
From:   Ben Greear <greearb@candelatech.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <10ab525d-cd22-18ec-3c82-c651a6749c0e@candelatech.com>
Organization: Candela Technologies
Message-ID: <be9542f1-cf9c-9939-73c5-3305d1072a3b@candelatech.com>
Date:   Mon, 21 Sep 2020 15:06:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <10ab525d-cd22-18ec-3c82-c651a6749c0e@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 12:50 PM, Ben Greear wrote:
> Hello,
> 
> I'm seeing this build failure, any idea what is the issue?  I've cleared my ccache (ccache --clear)
> but that did not help.  A pull from this morning builds on Fedora-29 with same .config file.  I tried
> that same commit on my F32 system to no success, so it seems like it might be something with
> my F32 compiler/system.

Looks like my git tree was corrupted.  A fresh one is working better.

Thanks,
Ben

