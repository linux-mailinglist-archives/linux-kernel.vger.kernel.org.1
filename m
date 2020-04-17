Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4534D1AD7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgDQHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:48:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgDQHsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:48:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE889AF0D;
        Fri, 17 Apr 2020 07:48:33 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To:     Deep Shah <sdeep@vmware.com>, linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, thellstrom@vmware.com,
        virtualization@lists.linux-foundation.org
References: <20200416234520.GA1700@prme-mon-cfl-mlw-07>
 <84f719e9-3af0-4242-f50b-990371d4768a@suse.com>
Message-ID: <155feefc-598b-023d-1e78-56cbce9f4a1a@suse.com>
Date:   Fri, 17 Apr 2020 09:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <84f719e9-3af0-4242-f50b-990371d4768a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.20 08:22, Jürgen Groß wrote:
> On 17.04.20 01:45, Deep Shah wrote:
>> Thomas Hellstrom will be handing over VMware's maintainership of these
>> interfaces to Deep Shah.
>>
>> Signed-off-by: Deep Shah <sdeep@vmware.com>
>> Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Acked-by: Juergen Gross <jgross@suse.com>

BTW, I can carry this patch through the Xen tree if nobody else wants to
take it...


Juergen
