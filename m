Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA33B19FB78
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgDFR1r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Apr 2020 13:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDFR1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:27:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93A78BE46;
        Mon,  6 Apr 2020 17:27:43 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>,
        Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cifs: Allocate crypto structures on the fly for
 calculating signatures of incoming packets
In-Reply-To: <CAKywueTyHNw5P1M4WR+SdBKU-yXvJEfJc5VSONveNBZm-dOjKQ@mail.gmail.com>
References: <1585696903-96794-1-git-send-email-longli@linuxonhyperv.com>
 <CAKywueRg8kJ+0aOehM-QKGuRwbDSb2TA5vNje8eSCdMqBT+EdQ@mail.gmail.com>
 <BN8PR21MB11559BF18DF932A38624369ECEC70@BN8PR21MB1155.namprd21.prod.outlook.com>
 <CAKywueRBghVuNtfP0XdLYL-wS_Nfci8uF_7pRPSjvQDif22BFQ@mail.gmail.com>
 <CAKywueTyHNw5P1M4WR+SdBKU-yXvJEfJc5VSONveNBZm-dOjKQ@mail.gmail.com>
Date:   Mon, 06 Apr 2020 15:05:55 +0200
Message-ID: <87h7xwn4r0.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Shilovsky <piastryyy@gmail.com> writes:
> + Aurelien
>
> Ok, before negotiate tcpStatus is not CifsGood, so, the allocation
> won't be skipped. I think this function should be no-op for all
> protocols except SMB 3.1.1 to reflect the meaning. Other protocols
> don't use preauth hash anyway.
>
> @Aurelien, @everybody, what would be your thoughts about moving
> protocol version check from IF block to the top of the function thus
> skipping to allocate preauth hash for protocols that don't need it? In
> this case Long's patch will require a change to keep
> smb2_crypto_shash_allocate() and its invocation.

Sounds good. I think we could go even further and do preauth crypto
alloc/dealloc all in the preauth hash compute function too and remove
the pointers from the server struct (except for the byte array with the
hash result). It only runs during negprot+session establishement which
is not a hot path at all and would keep the memory model simpler.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
