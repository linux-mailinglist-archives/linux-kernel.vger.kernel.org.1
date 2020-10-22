Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B269C296771
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373085AbgJVWq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:46:57 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:55860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S372980AbgJVWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:46:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D11DF18029120;
        Thu, 22 Oct 2020 22:46:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2693:2828:2890:2901:2910:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4042:4321:4605:5007:6119:7903:8957:9010:10004:10400:11026:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13019:13095:13439:14181:14659:14721:21080:21221:21433:21450:21451:21611:21627:21660:21990:30001:30003:30012:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kiss89_0b08c1a27254
X-Filterd-Recvd-Size: 3400
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 22:46:53 +0000 (UTC)
Message-ID: <b853a8ab4daface74075e93d83f94655f13a2979.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
Date:   Thu, 22 Oct 2020 15:46:50 -0700
In-Reply-To: <edaa9012-d512-26fc-0aca-f0eaf889a050@gmail.com>
References: <20201022145021.28211-1-yashsri421@gmail.com>
         <4cbbd8d8b6c4d686f71648af8bc970baa4b0ee9b.camel@perches.com>
         <5121bf7c-a126-6178-62ff-e54f0bb4cb6e@gmail.com>
         <67247b2d51aa8b2da7377e400e9191733144ed0f.camel@perches.com>
         <edaa9012-d512-26fc-0aca-f0eaf889a050@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 02:35 +0530, Aditya wrote:
> On 23/10/20 1:03 am, Joe Perches wrote:
> > On Fri, 2020-10-23 at 00:44 +0530, Aditya wrote:
> > > On 22/10/20 9:40 pm, Joe Perches wrote:
> > > > On Thu, 2020-10-22 at 20:20 +0530, Aditya Srivastava wrote:
> > > > > Presence of hexadecimal address or symbol results in false warning
> > > > > message by checkpatch.pl.
> > > > []
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > []
> > > > > @@ -3051,7 +3051,10 @@ sub process {
> > > > >  		}
> > > > >  
> > > > >  # check for repeated words separated by a single space
> > > > > -		if ($rawline =~ /^\+/ || $in_commit_log) {
> > > > > +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
> > > > > +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> > > > > +		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
> > > > 
> > > > Alignment and use \b before and after the regex please.
> > > 
> > > If we use \b either before or after or both it does not match patterns
> > > such as:
> > > +   -rw-r--r--. 1 root root 112K Mar 20 12:16'
> > selinux-policy-3.14.4-48.fc31.noarch.rpm
> > 
> > OK, thanks, it's good you checked.
> > 
> > > > []
> > > > What does all this code actually avoid?
> > > 
> > > Sir, there are multiple variations of hex for which this warning is
> > > occurring, for eg:
> > > 1) 00 c0 06 16 00 00 ff ff 00 93 1c 18 00 00 ff ff  ................
> > > 2) ffffffff ffffffff 00000000 c070058c
> > > 3)     f5a:       48 c7 44 24 78 ff ff    movq
> > > $0xffffffffffffffff,0x78(%rsp)
> > > 4) +    fe fe
> > > 5) +    fe fe   - ? end marker ?
> > > 6) Code: ff ff 48 (...)
> > 
> > So why not just match first with /^[0-9a-f]+$/i ?
> > 
> > Doesn't that match all the cases listed above?
> > 
> > 
> 
> Then, we'll not be able to account for cases such as:
> 
> 1) +     * sets this to -1, the slack value will be calculated to be be
> halfway [For 'be' 'be']
> 2) + * @seg: index of packet segment whose raw fields are to be be
> extracted [For 'be' 'be']
> 3) Let's also add add a note about using only the l3 access without l4
> [For 'add' 'add']

Like the use of long, I think you're better off with
either a list or hash of specific words to ignore.



