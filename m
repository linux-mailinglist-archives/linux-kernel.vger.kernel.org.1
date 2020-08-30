Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E2256AF4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgH3AoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 20:44:03 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:43662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728246AbgH3AoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:44:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 61C8737F1;
        Sun, 30 Aug 2020 00:44:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4118:4321:5007:8603:8660:10004:10848:11026:11232:11658:11914:12049:12296:12297:12740:12760:12895:13148:13161:13229:13230:13439:13548:14659:21080:21433:21611:21627:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:53,LUA_SUMMARY:none
X-HE-Tag: wine80_5804e8727082
X-Filterd-Recvd-Size: 7121
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Aug 2020 00:43:59 +0000 (UTC)
Message-ID: <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Aug 2020 17:43:58 -0700
In-Reply-To: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 16:48 -0700, Joe Perches wrote:
> Output defects can exist in sysfs content using sprintf and snprintf.
> 
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
> 
> Add a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done.
> 
> Add a generic sysfs_emit_at function that can be used in multiple
> call situations that also ensures that no overrun is done.

This preliminary coccinelle script converts ~5000 instances treewide.
There are still many remaining instances that could be converted.

$ git grep -w sysfs_emit -- '*.[ch]'|wc -l
4702
$ git grep -w sysfs_emit_at -- '*.[ch]'|wc -l
229

$ cat sysfs_emit.cocci
@@
identifier d_show =~ "^.*show.*$";
identifier arg1, arg2, arg3;
@@
ssize_t d_show(struct device *
-	arg1
+	dev
	, struct device_attribute *
-	arg2
+	attr
	, char *
-	arg3
+	buf
	)
{
	...
(
-	arg1
+	dev
|
-	arg2
+	attr
|
-	arg3
+	buf
)
	...
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show =~ "^.*show.*$";
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}

@@
identifier k_show =~ "^.*show.*$";
identifier arg1, arg2, arg3;
@@
ssize_t k_show(struct kobject *
-	arg1
+	kobj
	, struct kobj_attribute *
-	arg2
+	attr
	, char *
-	arg3
+	buf
	)
{
	...
(
-	arg1
+	kobj
|
-	arg2
+	attr
|
-	arg3
+	buf
)
	...
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
expression chr;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
identifier len;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier k_show =~ "^.*show.*$";
identifier kobj, attr, buf;
expression chr;
@@

ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}


