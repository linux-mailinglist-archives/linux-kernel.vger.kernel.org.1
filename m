Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA6F1A2F47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 02:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgDIGhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:37:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D9ADAC64;
        Thu,  9 Apr 2020 06:37:49 +0000 (UTC)
Subject: Re: Use of VM_IOREMAP in xenbus
To:     Christoph Hellwig <hch@lst.de>, Wei Liu <wl@xen.org>
Cc:     Bob Liu <bob.liu@oracle.com>,
        "Durrant, Paul" <pdurrant@amazon.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200409061846.GA30241@lst.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8074b77d-d784-95ee-8d47-069827855876@suse.com>
Date:   Thu, 9 Apr 2020 08:37:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409061846.GA30241@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjusting recipient list (dropping David, new mail addresses for Wei and
Paul).

On 09.04.20 08:18, Christoph Hellwig wrote:
> Hi Wei,
> 
> commit ccc9d90a9a8b5 ("xenbus_client: Extend interface to support
> multi-page ring") addes a use of vmap in what is now
> xenbus_map_ring_valloc_hvm, and uses the VM_IOREMAP flag that is
> only really intended for implementing ioremap.  Do you remember
> what the reason is that this flag was used?
> 

Juergen
