Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82AA23043B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgG1Hi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 03:38:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:49998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgG1Hi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:38:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4630AD32;
        Tue, 28 Jul 2020 07:38:37 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] Few bug fixes and Convert to pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6za8U04U2TQhe6DUCv7B4h9L-iqPtyE1DuALXUWOD=1M3A@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <d6489b26-3891-cfc2-e614-1d5677d3999f@suse.com>
Date:   Tue, 28 Jul 2020 09:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6za8U04U2TQhe6DUCv7B4h9L-iqPtyE1DuALXUWOD=1M3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.20 09:10, Souptick Joarder wrote:
> Hi Boris,
> 
> On Sun, Jul 12, 2020 at 9:01 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> This series contains few clean up, minor bug fixes and
>> Convert get_user_pages() to pin_user_pages().
>>
>> I'm compile tested this, but unable to run-time test,
>> so any testing help is much appriciated.
>>
>> v2:
>>          Addressed few review comments and compile issue.
>>          Patch[1/2] from v1 split into 2 in v2.
>> v3:
>>          Address review comment. Add review tag.
>>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Paul Durrant <xadimgnik@gmail.com>
>>
>> Souptick Joarder (3):
>>    xen/privcmd: Corrected error handling path
>>    xen/privcmd: Mark pages as dirty
>>    xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
> 
> Does this series looks good to go for 5.9 ?

Yes. I already have it in my queue.


Juergen
