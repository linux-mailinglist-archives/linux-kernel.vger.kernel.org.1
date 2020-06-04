Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3781EDB14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 04:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFDCNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 22:13:15 -0400
Received: from namei.org ([65.99.196.166]:40866 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFDCNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 22:13:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0542D9ZU000367;
        Thu, 4 Jun 2020 02:13:09 GMT
Date:   Thu, 4 Jun 2020 12:13:09 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SELinux patches for v5.8
In-Reply-To: <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.2006041212110.335@namei.org>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com> <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com> <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com> <alpine.LRH.2.21.2006040809280.6050@namei.org>
 <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020, Casey Schaufler wrote:

> On 6/3/2020 3:12 PM, James Morris wrote:
> > On Wed, 3 Jun 2020, Casey Schaufler wrote:
> >
> >> The use of security modules was expected to be rare.
> > This is not correct. Capabilities were ported to LSM and stacked from the 
> > beginning, and several major distros worked on LSM so they could ship 
> > their own security modules.
> 
> Capabilities has always been a special case.
> Until Android adopted SELinux the actual use of LSMs was rare.

Nope, it was enabled by default in several distros and very widely 
deployed in the govt space (at least).

-- 
James Morris
<jmorris@namei.org>

