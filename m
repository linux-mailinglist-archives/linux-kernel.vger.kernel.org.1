Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE928072F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbgJASrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:47:15 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:44076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729047AbgJASrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:47:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 02CB3837F24C;
        Thu,  1 Oct 2020 18:47:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:871:968:973:982:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1535:1541:1575:1594:1711:1730:1747:1764:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3870:3872:3874:4419:5007:6506:6747:6748:7281:7875:10004:10400:10848:11026:11604:11658:11914:12050:12297:12438:13439:14659:21080:21451:21627:21740:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: pain06_380f3a22719d
X-Filterd-Recvd-Size: 5917
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 18:47:07 +0000 (UTC)
Message-ID: <bab3ecae932cb41106834156abbd27159d937e67.camel@perches.com>
Subject: external tool to remove embedded filenames
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-mentors@selenic.com" <kernel-mentors@selenic.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Date:   Thu, 01 Oct 2020 11:47:06 -0700
In-Reply-To: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
References: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
Content-Type: multipart/mixed; boundary="=-2PVQdg6bKC9Euge47oAr"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2PVQdg6bKC9Euge47oAr
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

It's rather unnecessary for files to contain their
path/filename in source code comments.

Here's a trivial little script that can remove
embedded filenames in c90 style comments from files.

This requires git.

It does the following types of removals:

remove individual lines like /* filename */ completely
remove filename from /* filename -- comment */, leave /* comment */
remove filename and any trailing ' *\n' from /* filename, leave /*
remove filename from /* filename, leave /*
remove filename from continuation ' * filename -- comment' leave ' * comment'
remove filename and any trailing ' *\n' from continuation ' * filename\n *\n'

It seems to work well enough.

It does not handle c99 comments.
No // filename variants are removed.

Running it on today's -next gives:

$ perl remove_embedded_filenames.pl
$ git diff --shortstat
 2310 files changed, 354 insertions(+), 4239 deletions(-)

It's also possible to give any filename or path
as an argument to the script

For instance:

$ perl remove_embedded_filenames.pl drivers/net


--=-2PVQdg6bKC9Euge47oAr
Content-Type: application/x-perl; name="remove_embedded_filenames.pl"
Content-Disposition: attachment; filename="remove_embedded_filenames.pl"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9wZXJsIC13CgojIHNjcmlwdCB0byByZW1vdmUgKiA8ZmlsZW5hbWU+IGNvbW1l
bnRzOwojIHVzZTogcGVybCByZW1vdmVfZW1iZWRkZWRfZmlsZW5hbWVzLnBsIDxwYXRoc3xmaWxl
cz4KIyBlLmcuOiBwZXJsIHJlbW92ZV9lbWJlZGRlZF9maWxlbmFtZXMucGwgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwKCnVzZSBzdHJpY3Q7CgpteSAkUCA9ICQwOwpteSAkbW9kaWZpZWQgPSAw
OwpteSAkcXVpZXQgPSAwOwoKc3ViIGV4cGFuZF90YWJzIHsKICAgIG15ICgkc3RyKSA9IEBfOwoK
ICAgIG15ICRyZXMgPSAnJzsKICAgIG15ICRuID0gMDsKICAgIGZvciBteSAkYyAoc3BsaXQoLy8s
ICRzdHIpKSB7CglpZiAoJGMgZXEgIlx0IikgewoJICAgICRyZXMgLj0gJyAnOwoJICAgICRuKys7
CgkgICAgZm9yICg7ICgkbiAlIDgpICE9IDA7ICRuKyspIHsKCQkkcmVzIC49ICcgJzsKCSAgICB9
CgkgICAgbmV4dDsKCX0KCSRyZXMgLj0gJGM7CgkkbisrOwogICAgfQoKICAgIHJldHVybiAkcmVz
Owp9CgpteSAkYXJncyA9IGpvaW4oIiAiLCBAQVJHVik7Cm15ICRvdXRwdXQgPSBgZ2l0IGxzLWZp
bGVzIC0tICRhcmdzYDsKbXkgQGZpbGVzID0gc3BsaXQoIlxuIiwgJG91dHB1dCk7Cgpmb3JlYWNo
IG15ICRmaWxlIChAZmlsZXMpIHsKICAgIG15ICRmOwogICAgbXkgJGN2dCA9IDA7CiAgICBteSAk
dGV4dDsKCiMgcmVhZCB0aGUgZmlsZQoKICAgIG5leHQgaWYgKCgtZCAkZmlsZSkpOwoKICAgIG9w
ZW4oJGYsICc8JywgJGZpbGUpCglvciBkaWUgIiRQOiBDYW4ndCBvcGVuICRmaWxlIGZvciByZWFk
XG4iOwogICAgJHRleHQgPSBkbyB7IGxvY2FsKCQvKSA7IDwkZj4gfTsKICAgIGNsb3NlKCRmKTsK
CiAgICBuZXh0IGlmICgkdGV4dCBlcSAiIik7CgojIFJlbW92ZSB0aGUgZW1iZWRkZWQgZmlsZW5h
bWVzCgogICAgIyByZW1vdmUgaW5kaXZpZHVhbCBsaW5lcyBsaWtlIC8qIGZpbGVuYW1lICovIGNv
bXBsZXRlbHkKICAgICRjdnQgKz0gJHRleHQgPX4gc0AvXCpbIFx0XSsoPzpsaW51eFwvKT9cUSRm
aWxlXEVbIFx0XSpcKi9bIFx0XSpcbkBAZzsKICAgIHBvcygkdGV4dCkgPSAwOwogICAgIyByZW1v
dmUgZmlsZW5hbWVlIGZyb20gLyogZmlsZW5hbWUgLS0gY29tbWVudCAqLywgbGVhdmUgLyogY29t
bWVudCAqLwogICAgJGN2dCArPSAkdGV4dCA9fiBzQC9cKihbIFx0XSspKD86bGludXhcLyk/XFEk
ZmlsZVxFWyBcdF0qWzotXStbIFx0XSpALyokMUBnOwogICAgcG9zKCR0ZXh0KSA9IDA7CiAgICAj
IHJlbW92ZSBmaWxlbmFtZSBhbmQgYW55IHRyYWlsaW5nICcgKlxuJyBmcm9tIC8qIGZpbGVuYW1l
LCBsZWF2ZSAvKgogICAgJGN2dCArPSAkdGV4dCA9fiBzQC9cKihbIFx0XSspKD86bGludXhcLyk/
XFEkZmlsZVxFWyBcdF0qXG4oWyBcdF0qXCpbIFx0XSpcbikqKD86WyBcdF0qXCopP0AvKkBnOwog
ICAgcG9zKCR0ZXh0KSA9IDA7CiAgICAjIHJlbW92ZSBmaWxlbmFtZSBmcm9tIC8qIGZpbGVuYW1l
LCBsZWF2ZSAvKgogICAgJGN2dCArPSAkdGV4dCA9fiBzQC9cKihbIFx0XSspKD86bGludXhcLyk/
XFEkZmlsZVxFWyBcdF0qXG5ALypAZzsKICAgIHBvcygkdGV4dCkgPSAwOwogICAgIyByZW1vdmUg
ZmlsZW5hbWUgZnJvbSBjb250aW51YXRpb24gJyAqIGZpbGVuYW1lIC0tIGNvbW1lbnQnCiAgICAj
IGxlYXZlICcgKiBjb21tZW50JwogICAgJGN2dCArPSAkdGV4dCA9fiBzLyhbIFx0XSspXCooWyBc
dF0qKSg/OmxpbnV4XC8pP1xRJGZpbGVcRVsgXHRdKls6LV0rWyBcdF0qLyQxKiQyL2c7CiAgICBw
b3MoJHRleHQpID0gMDsKICAgICMgcmVtb3ZlIGZpbGVuYW1lIGFuZCBhbnkgdHJhaWxpbmcgJyAq
XG4nIGZyb20KICAgICMgY29udGludWF0aW9uICcgKiBmaWxlbmFtZVxuICpcbicKICAgICRjdnQg
Kz0gJHRleHQgPX4gcy8oWyBcdF0qKVwqKFsgXHRdKikoPzpsaW51eFwvKT9cUSRmaWxlXEVbIFx0
XSpcbihbIFx0XSpcKlsgXHRdKlxuKSovL2c7CiAgICBwb3MoJHRleHQpID0gMDsKCiMgd3JpdGUg
dGhlIGZpbGUgaWYgc29tZXRoaW5nIHdhcyBjaGFuZ2VkCgogICAgaWYgKCRjdnQgPiAwKSB7Cgkk
bW9kaWZpZWQgPSAxOwoJcHJpbnQoIiRmaWxlXG4iKTsKCW9wZW4oJGYsICc+JywgJGZpbGUpCgkg
ICAgb3IgZGllICIkUDogQ2FuJ3Qgb3BlbiAkZmlsZSBmb3Igd3JpdGVcbiI7CglwcmludCAkZiAk
dGV4dDsKCWNsb3NlKCRmKTsKICAgIH0KfQoKaWYgKCRtb2RpZmllZCAmJiAhJHF1aWV0KSB7CiAg
ICBwcmludCA8PEVPVDsKCldhcm5pbmc6IHRoZXNlIGNoYW5nZXMgbWF5IG5vdCBiZSBjb3JyZWN0
LgoKVGhlc2UgY2hhbmdlcyBzaG91bGQgYmUgY2FyZWZ1bGx5IHJldmlld2VkIG1hbnVhbGx5IGFu
ZCBub3QgY29tYmluZWQgd2l0aAphbnkgZnVuY3Rpb25hbCBjaGFuZ2VzLgoKQ29tcGlsZSwgYnVp
bGQgYW5kIHRlc3QgeW91ciBjaGFuZ2VzLgoKWW91IHNob3VsZCB1bmRlcnN0YW5kIGFuZCBiZSBy
ZXNwb25zaWJsZSBmb3IgYWxsIG9iamVjdCBjaGFuZ2VzLgoKTWFrZSBzdXJlIHlvdSByZWFkIERv
Y3VtZW50YXRpb24vU3VibWl0dGluZ1BhdGNoZXMgYmVmb3JlIHNlbmRpbmcKYW55IGNoYW5nZXMg
dG8gcmV2aWV3ZXJzLCBtYWludGFpbmVycyBvciBtYWlsaW5nIGxpc3RzLgpFT1QKfQo=


--=-2PVQdg6bKC9Euge47oAr--

